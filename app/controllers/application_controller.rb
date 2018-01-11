class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def profile
  	@user=User.find_by_id(params[:userid])
    @attempts=Attempt.where(user_id: params[:userid])
    @quizesattempted=@attempts.pluck(:test_id).uniq.count
    @correct=@attempts.sum(:status)
    @wrong=@attempts.length-@correct
  end

  def editprofile
  	@user=User.find_by_id(params[:userid])
  	if(@user!=current_user)
  		redirect_to '/'
  	end
  end

end
