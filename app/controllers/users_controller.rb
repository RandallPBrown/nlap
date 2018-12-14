class UsersController < ApplicationController
  layout 'scaffold'
  def dashboard          
    # @body_class = "with-sidebar show-sidebar"
    # @current_user = current_user
    @user_entry = Entry.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group(:id).order("entries.edate DESC")
    @user_entry_today = Entry.today.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group(:id).order("entries.edate DESC")
    @user_entry_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group(:id).order("entries.edate DESC")
    @user_entry_total_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).sum(:ovalue)
    @user_entry_tardy_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).where("occurrences.name = ?", "Tardy").count(:name)
    @user_entry_absent_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).where("occurrences.ovalue > ?", 0.5).count(:name)
  	@agent_chart_labels = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group("occurrences.name").order("occurrences.name DESC").pluck("occurrences.name")
  	@agent_chart_data = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group("occurrences.name").order("occurrences.name DESC").count("occurrences.name").values
    @user_writeup_written = Dap.written.joins(:writeup, :user).where("users.id = ?", current_user.id).count(:writeup_id)
  end
end
