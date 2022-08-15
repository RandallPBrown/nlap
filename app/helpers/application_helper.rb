module ApplicationHelper
  def app_name
    "Agent Portal"
  end

def sortable(column, title = nil)
  title ||= column.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
end

def new_parts
    @test = Part.all.where(:submitted_by => current_user.full_name, :read_at => nil).where.not(approved_by: nil).count
end

 def resource_name
    :user
  end

  def resource_class 
     User 
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def user_email
    current_user.email
  end  

  def user_department
    current_user.department.name
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.options = {'debug': false,'positionClass': 'toast-bottom-right','onclick': null,'fadeIn': 300,'fadeOut': 1000,'timeOut': 5000,'extendedTimeOut': 1000};toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def pending_count
    Part.all.where('parts.covered = ?', 'pending').count
  end
end
