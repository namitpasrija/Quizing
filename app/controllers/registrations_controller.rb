class RegistrationsController < Devise::RegistrationsController
	 protected
	
	  def after_inactive_sign_up_path_for(resource)
	    scope = Devise::Mapping.find_scope!(resource)
	    router_name = Devise.mappings[scope].router_name
	    context = router_name ? send(router_name) : self
	    context.respond_to?(:new_user_session_path) ? context.new_user_session_path : "/users/sign_in"
	  end

	  def sign_up_params
	  	hashh=Digest::MD5.hexdigest(params[:user][:email])
	  	params[:user][:profilePicUrl]='https://www.gravatar.com/avatar/'+hashh
	    params.require(:user).permit(:FirstName, :LastName, :Contact,:email, :Gender,:Dob,:password, :password_confirmation,:profilePicUrl)
	  end

	  def account_update_params
	  	hashh=Digest::MD5.hexdigest(params[:user][:email])
	  	params[:user][:profilePicUrl]='https://www.gravatar.com/avatar/'+hashh
	    params.require(:user).permit(:FirstName, :LastName, :Contact, :email,:Gender,:Dob,:password, :password_confirmation, :current_password,:profilePicUrl,:interests,:facebook,:linkedin,:twitter,:about,:profession,:profession_place,:country)
	  end

	  def update_resource(resource, params)
	    if params[:current_password].blank?
	     resource.update_without_password(params.except(:current_password))
	    else
	      resource.update_with_password(params)
	    end
	  end
	  
end
