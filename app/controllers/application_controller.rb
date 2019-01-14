class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
	def authorize_admin
	    redirect_to users_dashboard_path unless current_user.admin
	    #redirects to previous page
	end
end
