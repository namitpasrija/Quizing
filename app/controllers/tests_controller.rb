class TestsController < ApplicationController
	before_action :authenticate_user!, only: [:new,:create,:update,:register,:environment,:changeproblem,:attempt,:destroy,:testinfo]
	@@queans=Hash.new
	def index
		@time=Time.now.in_time_zone(TZInfo::Timezone.get('Asia/Kolkata'))
		@ongoingtests=Test.where("starttime<?",@time).where("endtime>?",@time)
		@upcomingtests=Test.where("starttime>?",@time).where("endtime>?",@time)
		@pasttests=Test.where("starttime<?",@time).where("endtime<?",@time)
	end

	def new
		@test=Test.new
	end

	def create
		@test=Test.new(set_params)
		@test.user=current_user
		@test.save
		# Resque.enqueue_at(@test.endtime,TestWorker,@test.id)
		redirect_to action: 'myTests'
	end


	def myTests
		@tests=Test.where(user: current_user)
	end


	def edit
		@test=Test.find_by_id(params[:testid])
		@problems=Problem.where(testid: params[:testid])
	end

	def update
		@test=Test.find_by(id: params[:testid])
		@test.update(set_params)
		@test.save
		redirect_to '/test/mytests'
	end


	def testinfo
		@test=Test.find_by_id(params[:testid])
		if(!@test)
			redirect_to 'index'
		end
	end

	def register
		@time=Time.now.in_time_zone(TZInfo::Timezone.get('Asia/Kolkata'))
		if(Test.find_by_id(params[:testid]).endtime<@time)
			redirect_to action: 'index'
		end
		@participation=Participation.new()
		@participation.user=current_user
		@participation.test_id=params[:testid]
		@participation.save
		redirect_to action: 'testinfo',testid: params[:testid]
	end

	
	def environment
		@time=Time.now.in_time_zone(TZInfo::Timezone.get('Asia/Kolkata'))
		@test=Test.find_by_id(params[:testid])

		if !(@test.endtime>@time && @test.starttime<@time)
			redirect_to action: 'index'
		end

		enrollment=Enrollment.where(:user_id=>current_user.id).where(:test_id=>@test.id)
		
		if(enrollment.empty?)
			enrollment=Enrollment.new()
			enrollment.test_id=@test.id
			enrollment.user=current_user
			enrollment.startedAt=@time
			enrollment.endsAt=@time+@test.duration.minutes
			enrollment.save
		else
			enrollment=enrollment.first
		end

		if(enrollment.submittedStatus==true || @time>enrollment.endsAt)
			redirect_to action: 'preenrolled'
		end


		 @totalproblems=Problem.where(:testid=>@test.id).length
	end

	def changeproblem
		@qno=params[:qno]
		@test=params[:testid]
		@problem=Problem.where(:testid=>@test).where(:queno=>@qno)[0]
		@attempts=Attempt.where(:user_id=>current_user.id).where(:problem_id=>@problem.id)
		@answered=""
		if(!@attempts.empty?)
			@answered=@attempts.first.answered
		end
	end


	def attempt
		@attempts=Attempt.where(:user_id=>current_user.id).where(:problem_id=>params[:problemid])
		if(@attempts.empty?)
			@attempt=Attempt.new()
			@attempt.user=current_user
			@attempt.test_id=params[:testid]
			@attempt.problem_id=params[:problemid]
			@attempt.answered=""

			params[:options][0].keys.each do |key|
				@attempt.answered+=key
				@attempt.answered+=","
			end

			if(!@@queans.key?(params[:problemid]))
				problem=Problem.find_by_id(params[:problemid])
				@@queans[params[:problemid]]=Hash.new
				@@queans[params[:problemid]]['answer']=problem.answer
				@@queans[params[:problemid]]['marks']=problem.marks
				@@queans[params[:problemid]]['negativemarks']=problem.negativemarks
			end

			@answer=@@queans[params[:problemid]]['answer']
			@marks=@@queans[params[:problemid]]['marks']
			@negativemarks=@@queans[params[:problemid]]['negativemarks']

			if(@answer+','==@attempt.answered)
				@attempt.status=1
				@attempt.marks=@marks
			else
				@attempt.status=0
				@attempt.marks=@negativemarks
			end
			@attempt.save
		else
			@attempt=@attempts.first
			@attempt.answered=""
			
			params[:options][0].keys.each do |key|
				@attempt.answered+=key
				@attempt.answered+=","
			end

			if(!@@queans.key?(params[:problemid]))
				problem=Problem.find_by_id(params[:problemid])
				@@queans[params[:problemid]]=Hash.new
				@@queans[params[:problemid]]['answer']=problem.answer
				@@queans[params[:problemid]]['marks']=problem.marks
				@@queans[params[:problemid]]['negativemarks']=problem.negativemarks
			end

			@answer=@@queans[params[:problemid]]['answer']
			@marks=@@queans[params[:problemid]]['marks']
			@negativemarks=@@queans[params[:problemid]]['negativemarks']

			if(@answer+','==@attempt.answered)
				@attempt.status=1
				@attempt.marks=@marks
			else
				@attempt.status=0
				@attempt.marks=@negativemarks
			end
			@attempt.save
		end

		return
	end	

	def destroy
	end

	def preenrolled
	end

	def scoreboard
		@test=Test.find_by_id(params[:testid])
		@currenttime=Time.now.in_time_zone(TZInfo::Timezone.get('Asia/Kolkata'))
		@enrollments=Enrollment.where(:test_id=>@test.id)
		@problems=Problem.where(:testid=>@test.id)

		if(@currenttime>@test.endtime)
			if(Computed.where(:test_id=>@test.id).empty?)
				computed=Computed.create(test_id: @test.id)
				@maxscore=@problems.sum(:marks)
				
				(0..@enrollments.length-1).each do |i|
					userid=@enrollments[i].user_id
					@userattempts=Attempt.where(:user_id =>userid).where(:test_id=>@test.id)

					@enrollments[i].score=@userattempts.sum(:marks)
					@enrollments[i].correctAnswers=@userattempts.sum(:status)
					@enrollments[i].maxscore=@maxscore


					@enrollments[i].save
				end
			end
			@flag=1
		else
			@flag=0
		end
	end

	private

		def set_params
			params.require(:test).permit(:title,:description,:duration,:starttime,:endtime,:conductedby,:user_id,:fee,:prize,:instructions,:password,:ttype)
		end
end
	