class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :declare_kudo
	def authorize_admin
	    redirect_to users_dashboard_path unless current_user.admin
	    #redirects to previous page
	end

	def after_sign_in_path_for(resource)
	  stored_location_for(resource) || users_home_path
	end
	
	def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      new_user_session_path
    else
      root_path
    end
  end

	def declare_kudo
		@kudo = Kudo.new
	end
end
