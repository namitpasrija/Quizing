class ProblemsController < ApplicationController
	before_action :authenticate_user!,:authorise_user

	def index
	end

	def new
		@testid=params[:testid]
		@problem=Problem.new
	end

	def create
		@problem=Problem.new(set_params)
		@problem.user=current_user
		@problem.save
		redirect_to "/test/edit/#{@problem.testid}"
	end

	def edit
		@testid=params[:testid]
		@problem=Problem.find_by(id: params[:problemid])
	end

	def update
		@problem=Problem.find_by(id: params[:problemid])
		@problem.update(set_params)
		@problem.save

		@attempts=Attempt.where(problem_id: params[:problemid])
		@computed=Computed.where(:test_id=>@problem.testid)
		
		if !(@computed.blank?)
			@computed.destroy_all
		end

		answer=@problem.answer
		marks=@problem.marks
		negmarks=@problem.negativemarks

		@attempts.each do |attempt|
			if(answer+','==attempt.answered)
				attempt.status=1
				attempt.marks=marks
			else
				attempt.status=0
				attempt.marks=negmarks
			end
			attempt.save
		end

		redirect_to '/'
	end

	def destroy
		@problems=Problem.find_by(id: params[:problemid])
		@attempts=Attempt.where(problem_id: params[:problemid])
		@computed=Computed.where(:test_id=>@problem.testid)
		
		if !(@computed.blank?)
			@computed.destroy_all
		end

		@attempts.destroy
		@problems.destroy
		redirect_to '/test/mytests'
	end
	
	private

		def set_params
			params.require(:problem).permit(:answer,:queno,:que,:option1,:option2,:option3,:option4,:option5,:option6,:option7,:option8,:option9,:option10,:subject,:testid,:option1,:difflevel,:marks)
		end

		def authorise_user
			if(params[:testid])
				@test=Test.find_by_id(params[:testid])
				if(current_user!=@test.user)
					redirect_to '/'
				end
			end
		end

end
