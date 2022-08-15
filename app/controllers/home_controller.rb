class HomeController < ApplicationController
  layout 'application'

  def index

  end

  def dashboard          
    @body_class = "with-sidebar show-sidebar"

  end
end
