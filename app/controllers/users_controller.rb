class UsersController < ApplicationController
  layout 'scaffold'
  before_action :authorize_admin, except: [:show, :dashboard, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :is_admin?

  def index
    @users = User.includes(:daps, agent: :entries).joins(agent: :entries).order('users.first_name asc')
  end

  def dashboard          
    # @body_class = "with-sidebar show-sidebar"
    # @current_user = current_user
    @user_entry = Entry.occurrence_user.where("users.id = ?", current_user.id).group('agents.id', 'occurrences.id', 'departments.id', 'users.id').includes(:occurrence, agent: [:department, :user]).ue
    @user_entry_today = Entry.today.occurrence_user.where("users.id = ?", current_user.id).ue
    @user_entry_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).ue
    @user_entry_total_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).uete
    @user_entry_tardy_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).uete2
    @user_entry_absent_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).ueae
  	@agent_chart_labels_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).acl
  	@agent_chart_data_effective = Entry.effective.occurrence_user.where("users.id = ?", current_user.id).acd
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
      format.json {render :json => @user_entry}
    end
  end

  def show
    redirect_to agent_path(@user.agent.id)
  end

  # GET /agents/new
  def new
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) ||  current_user.has_role?(:trainer) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @user = User.new
    else
      redirect_to agents_path, notice: 'Unauthorized'
    end
  #  @departments = Department.new
  end

  # GET /agents/1/edit
  def edit
  end

  # POST /agents
  def create
      @user = User.new(user_params)
      if @user.save
        @user.add_role params[:user][:role]
        # UserMailer.welcome_email(@user).deliver_now
        redirect_to agents_path, notice: 'User was successfully created.'
        Agent.create({:department_id => @user.department_id, :user_id => @user.id})
      else
        render :new
      end
  end

  # PATCH/PUT /agents/1
  def update
    if (current_user.admin) then
      if @user.update_without_password(user_params)
        @user.roles = []
        @user.add_role params[:user][:role]
        Agent.where("user_id = ?", @user.id).update({:department_id => @user.department_id, :user_id => @user.id})
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    else
      if @user.update(user_params)
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
  redirect_to agents_path, notice: 'User was successfully destroyed.'
  else
    redirect_to agents_path, notice: 'Unauthorized'
  end
end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:extension, :id, :first_name, :last_name, :email, :department_id, :password, :password_confirmation, :department, :agent_id, :role, :admin)
    end
end
