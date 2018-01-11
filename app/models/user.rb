class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_presence_of :FirstName
  validates_presence_of :LastName
  validates_uniqueness_of :Contact
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   has_many :problems

   def update_without_password(params, *options)
	    if params[:password].blank?
	      params.delete(:password)
	      params.delete(:password_confirmation) if params[:password_confirmation].blank?
	    end

	    result = update_attributes(params, *options)
	    clean_up_passwords
	    result
  	end

end
