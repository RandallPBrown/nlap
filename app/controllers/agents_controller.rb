class AgentsController < ApplicationController
  layout "scaffold"
  before_action :authorize_admin, except: [:show]
  before_action :set_agent, only: [:show, :edit, :update, :destroy]


  # GET /agents
  def index
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
    # @agent = Agent.all
    # @agent = Agent.all
    # @users = User.with_role(:agent).all
      if params[:search].present?
        @agents = Agent.includes(:user, :department, entries: :user, user: :daps).joins(:user).perform_search(params[:search]).paginate(page: params[:page], :per_page => 15)
      else
        @agents = Agent.includes(:user, :department, entries: :user, user: :daps).joins(:user).order('users.first_name asc').paginate(page: params[:page], :per_page => 15)
      end
    else
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    end
    # @occurrences_since = Dap.find_by(user_id: @users.ids) 
  end

  # GET /agents/1
  def show
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @user_entry = Entry.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).group(:id).order("entries.edate DESC").paginate(page: params[:page], :per_page => 3)
      @user_entry_today = Entry.today.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).group(:id).order("entries.edate DESC")
      @user_entry_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).group(:id).order("entries.edate DESC")
      @user_entry_total_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).sum(:ovalue)
      @user_entry_tardy_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).where("occurrences.name = ?", "Tardy").count(:name)
      @user_entry_absent_effective = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).where("occurrences.ovalue > ?", 0.5).count(:name)
      @agent_chart_labels = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).group("occurrences.name").order("occurrences.name DESC").pluck("occurrences.name")
      @agent_chart_data = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @agent.user.id).group("occurrences.name").order("occurrences.name DESC").count("occurrences.name").values
      @user_writeup_written = Dap.written.joins(:writeup, :user).where("users.id = ?", @agent.user.id).count(:writeup_id)
      @user_dap = Dap.joins(:writeup, :user).where("users.id = ?", @agent.user.id).group(:id).order("daps.ddate DESC").paginate(page: params[:page], :per_page => 3)
      @user_entry_total_effective = Entry.effective.occurrence_user
        .where("users.id = ?", @agent.user.id)
        .sum(:ovalue)
      @user_dap_total_effective = Dap.written.joins(:user)
        .where("users.id = ?", @agent.user.id)
        .count(:id)  
    else 
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    end
  end

  # GET /agents/new
  def new
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @agent = Agent.new
  #  @departments = Department.new
    else
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    end
  end

  # GET /agents/1/edit
  def edit
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
    else
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    end
end

  # POST /agents
  def create
    @agent = Agent.new(agent_params)
    if @agent.save
      redirect_to @agent, notice: 'Agent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /agents/1
  def update
    if @agent.update(agent_params)
      redirect_to @agent, notice: 'Agent was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /agents/1
  def destroy
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @agent.destroy
      redirect_to agents_url, notice: 'Agent was successfully destroyed.'
    else
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def agent_params
      params.require(:agent).permit(:id, :fname, :lname, :hire, :dept, :department_id, :role, user: [:full_name], occurrence: [:ovalue])
    end
  
    def department_params
      params.require(:department).permit(:id, :desc, :name, :foreign_key)
    end
end
