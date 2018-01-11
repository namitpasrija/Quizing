class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def profile
  	@user=User.find_by_id(params[:userid])
  end

  def editprofile
  	@user=User.find_by_id(params[:userid])
  	if(@user!=current_user)
  		redirect_to '/'
  	end
  end

end
