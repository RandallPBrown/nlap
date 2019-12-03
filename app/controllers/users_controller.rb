# I don't get paid enough for this shit - Peyton
# Jeffrey Epstein didn't kill himself - Scooter

class UsersController < ApplicationController
  layout 'scaffold'
  before_action :authorize_admin, except: [:show, :dashboard, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :is_admin?

  def index
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @users = User.joins(agent: :department).order('users.first_name asc')
    else
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    end
  end

  def user_breakdown
    @users = User.all.joins(:department, :agent).order(params[:sort]).includes(:department)
    user_array = Array.new
    @users.each do |user| 
        user_array << {'ID': user.id, 
          'Agent': user.full_name, 
         'Department': user.department.name.truncate(15), 
         'Email': user.email.truncate(12), 
         'Role': user.roles.map {|r| r.name.capitalize }.first, 
         'Admin': if user.admin == true
                    'Y'
                  else
                    'N'
                  end, 
         'Deleted': if user.deleted_at.nil?
                    'N'
                  else
                    'Y'
                  end,
         '': (helpers.link_to(helpers.theme_icon_tag('eye'), user, 'data-toggle': 'tooltip', title: 'Show', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('pencil-alt'), edit_user_path(user), 'data-toggle': 'tooltip', title: 'Edit', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('trash'), user, 'data-toggle': 'tooltip', title: 'Delete', method: :delete, class: 'btn btn-link p-1'))}
    end 
    respond_to do |format|
      format.html
      format.json {render :json => user_array, public: true}
    end
  end

  def modal
    @err_log = ErrLog.find(params[:format])

  end

  def dashboard          
    # @body_class = "with-sidebar show-sidebar"
    # @current_user = current_user
    @uph = if Incentive.all.where("user_id = ?", current_user.id).where(:date => 1.month.ago.beginning_of_day..Date.today.end_of_day).average(:uph).nil?
      "0"
    else
      Incentive.all.where("user_id = ?", current_user.id).where(:date => 1.month.ago.beginning_of_day..Date.today.end_of_day).average(:uph)
    end
    @occ = if Incentive.all.where("user_id = ?", current_user.id).where(:date => 1.month.ago.beginning_of_day..Date.today.end_of_day).average(:occupancy).nil?
      "0"
    else
      Incentive.all.where("user_id = ?", current_user.id).where(:date => 1.month.ago.beginning_of_day..Date.today.end_of_day).average(:occupancy)
    end
    @incentive_settings = IncentiveSetting.all.where("department_id = ?", current_user.department.id)
    @err_logs = ErrLog.all.where('user_id = ?', current_user.id)
    @err_logs_count = ErrLog.joins(:err_status, :err_name).includes(:err_status, :err_name).where("user_id = ?", current_user.id).where(:errdate => Date.today.beginning_of_month..Date.today.end_of_month).select(:err_names).where('err_names.errname = ?', 'Improvement Opportunity').select(:err_statuses).where('err_statuses.statusname = ? OR err_statuses.statusname = ?', 'Reviewed', 'Acknowledged').count(:id)
    @err_logs_dispute = ErrLog.joins(:err_status, :err_name).includes(:err_status, :err_name).where("user_id = ?", current_user.id).where(:errdate => Date.today.beginning_of_month..Date.today.end_of_month).select(:err_names).where('err_names.errname = ?', 'Improvement Opportunity').select(:err_statuses).where('err_statuses.statusname = ?', 'Dispute').count(:id)
    @err_logs_pending = ErrLog.joins(:err_status, :err_name).includes(:err_status, :err_name).where("user_id = ?", current_user.id).where(:errdate => Date.today.beginning_of_month..Date.today.end_of_month).select(:err_names).select(:err_statuses).where('err_statuses.statusname = ?', 'Pending').count(:id)

    @user_entry = Entry.occurrence_user.where("users.id = ?", current_user.id).group('agents.id', 'occurrences.id', 'departments.id', 'users.id').includes(:occurrence, agent: [:department, :user]).ue
    @user_entry_today = Entry.today.occurrence_user.where("users.id = ?", current_user.id).ue
    @user_entry_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).ue
    @user_entry_total_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).uete
    @user_entry_total_effective_monthly = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).uete_monthly
    @user_entry_tardy_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).uete2
    @user_entry_absent_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).ueae
  	
    @agent_chart_labels_effective = Incentive.all.where(:date => 7.days.ago.to_date..Date.today.to_date.end_of_day).where("user_id = ?", helpers.current_user.id).map { |l| l.date.strftime("%m/%d/%Y") }.to_a;
  	@agent_chart_data_effective = Incentive.all.where(:date => 7.days.ago.to_date..Date.today.to_date.end_of_day).where("user_id = ?", helpers.current_user.id).map { |l| l.uph }.to_a;
    @agent_chart_data_effective_occupancy = Incentive.all.where(:date => 7.days.ago.to_date..Date.today.to_date.end_of_day).where("user_id = ?", helpers.current_user.id).map { |l| l.occupancy }.to_a;
    

    @agent_chart_labels_total = Entry.all.occurrence_user.where("users.id = ?", current_user.id).acl
    @agent_chart_data_total = Entry.all.occurrence_user.where("users.id = ?", current_user.id).acd
    @user_writeup_written = Dap.written.joins(:writeup, :user).where("users.id = ?", current_user.id).count(:writeup_id)
    @user_dap = Dap.includes(:writeup, :user).joins(:writeup, :user).group('writeups.id', 'users.id').where("users.id = ?", current_user.id).group(:id).order("daps.ddate DESC")
    @user_dap_written = Dap.written.includes(:writeup, :user).joins(:writeup, :user).group('writeups.id', 'users.id').where("users.id = ?", current_user.id).group(:id).order("daps.ddate DESC").paginate(page: params[:page], :per_page => 3)
    @user_aht = AgentStat.all.group(:id).where("user_id = ?", current_user.id).where(:date => 2.months.ago.to_date..Date.today.to_date.end_of_day).group(:date)
    @user_aht_label = AgentStat.all.group(:id).where("user_id = ?", current_user.id).where(:date => 2.months.ago.to_date..Date.today.to_date.end_of_day)
    @calls = AgentStat.all.group(:id).where("user_id = ?", current_user.id).where(:date => 2.months.ago.to_date..Date.today.to_date.end_of_day).group(:date)
    respond_to do |format|
      format.html
      format.js
      format.json {render :json => @user_entry}

    end
  end

  def show
    redirect_to users_path(@user.agent.id)
  end

  # GET /agents/new
  def new
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) ||  current_user.has_role?(:trainer) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @user = User.new
    else
      redirect_to users_path, notice: 'Unauthorized'
    end
  #  @departments = Department.new
  end

  # GET /agents/1/edit
  def edit
  end

  def password_reset
    @user_update = User.find(params[:id])
    @user_update.password = "123456"
    @user_update.save
    redirect_to users_dashboard_path, notice: 'User was successfully updated.'
  end

  # POST /agents
  def create
      @user = User.new(user_params)
      if @user.save
        @user.add_role params[:user][:role]
        # UserMailer.welcome_email(@user).deliver_now
        redirect_to users_path, notice: 'User was successfully created.'
        Agent.create({:department_id => @user.department_id, :user_id => @user.id})
      else
        render :new
      end
  end

  # PATCH/PUT /agents/1
  def update
    if (current_user.admin) && @user.id != current_user.id
      if @user.update_without_password(user_params)
        @user.roles = []
        @user.add_role params[:user][:role]
        Agent.where("user_id = ?", @user.id).update({:department_id => @user.department_id, :user_id => @user.id})
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    else
      if @user.update_with_password(user_params)
        redirect_to users_dashboard_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  end

def destroy
  # DELETE /resource
  if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
    @user.soft_delete
    # Devise.sign_out_all_scopes ? sign_out : sign_out(@user)
    # set_flash_message :notice, :destroyed
    yield @user if block_given?
    # respond_with_navigational(@user){ redirect_to agents_path(@user.id) }

  # @user.destroy!
  redirect_to users_path, notice: 'User was successfully destroyed.'
  else
    redirect_to users_path, notice: 'Unauthorized'
  end
end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:extension, :id, :first_name, :last_name, :email, :department_id, :password, :password_confirmation, :department, :agent_id, :role, :admin, :current_password)
    end
end
