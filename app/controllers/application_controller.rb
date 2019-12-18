class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :declare_kudo
	def authorize_admin
	    redirect_to users_dashboard_path unless current_user.admin
	    #redirects to previous page
	end

	

	def declare_kudo
		@kudo = Kudo.new
	end
end
