class TestsController < ApplicationController
	before_action :authenticate_user!

	def index
		@time=Time.now
		@ongoingtests=Test.where("'startTime'<?",@time).where("'endTime'>?",@time)
		@upcomingtests=Test.where("'startTime'>?",@time).where("'endTime'>?",@time)
		@pasttests=Test.where("'startTime'<?",@time).where("'endTime'<?",@time)
	end

	def new
		@test=Test.new
	end

	def create
		@test=Test.new(set_params)
		@test.user=current_user
		@test.save
		redirect_to action: 'myTests'
	end


	def myTests
		@tests=Test.where(user: current_user)
	end


	def edit
		@test=Test.find_by_id(params[:testid])
		@problems=Problem.where(testid: params[:testid])
	end

	def instructions
		@testid=params[:testid]
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

	def environment
		if(Participation.where(:user_id=>current_user.id).where(:test_id=>params[:testid]).empty?)
			@participation=Participation.new()
			@participation.user=current_user
			@participation.test_id=params[:testid]
			@participation.save
			redirect_to action: 'instructions',testid: params[:testid]
		end
			
		@qno=params[:qno]
		@test=params[:testid]
		if(!params[:qno])
			@qno=1
		end

		@problem=Problem.where(:testid=>@test).where(:queno=>@qno).first
		@totalproblems=Problem.where(:testid=>@test)
		@answered=""
		if(@problem)
			@attempts=Attempt.where(:user_id=>current_user.id).where(:problem_id=>@problem.id)
			if(!@attempts.empty?)
				@answered=@attempts.first.answered
			end
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
			@attempt.answered=""
			params[:options][0].keys.each do |key|
				@attempt.answered+=key
				@attempt.answered+=","
			end
			@attempt.save
		end
	end	

	def destroy
	end

	private

		def set_params
			params.require(:test).permit(:title,:description,:duration,:startTime,:endTime,:conductedBy,:user_id,:fee,:prize,:instructions,:password,:tType)
		end
end
