class TestsController < ApplicationController
	before_action :authenticate_user!, only: [:new,:create,:update,:register,:environment,:changeproblem,:attempt,:destroy,:testinfo]

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
		Resque.enqueue_at(@test.endtime,TestWorker,@test.id)
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
			redirect_to '/'
		end
	end

	def register
		@time=Time.now.in_time_zone(TZInfo::Timezone.get('Asia/Kolkata'))
		if(Test.find_by_id(params[:testid]).endtime<@time)
			redirect_to action: '/'
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
			redirect_to action: '/'
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
			@attempt.save
		else
			@attempt=@attempts.first
			@attempt.answered=","
			if params[:options] 
				params[:options][0].keys.each do |key|
					@attempt.answered+=key
					@attempt.answered+=","
				end
			end
			@attempt.save
		end
	end	

	def destroy
	end

	private

		def set_params
			params.require(:test).permit(:title,:description,:duration,:starttime,:endtime,:conductedby,:user_id,:fee,:prize,:instructions,:password,:ttype)
		end
end
	