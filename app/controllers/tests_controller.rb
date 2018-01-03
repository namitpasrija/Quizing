class TestsController < ApplicationController
	before_action :authenticate_user!

	def index
		@ongoingtests=Test.where('startTime<?',Time.now).where('endTime>?',Time.now)
		@upcomingtests=Test.where('startTime>?',Time.now).where('endTime>?',Time.now)
		@pasttests=Test.where('startTime<?',Time.now).where('endTime<?',Time.now)
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

		@problem=Problem.where(:testid=>@test).where(:queno=>@qno)

	end

	def destroy
	end

	private

		def set_params
			params.require(:test).permit(:title,:description,:duration,:startTime,:endTime,:conductedBy,:user_id,:fee,:prize,:instructions,:password,:tType)
		end

end
