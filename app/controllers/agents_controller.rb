class AgentsController < ApplicationController
  layout "scaffold"

  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  def index
    # @agent = Agent.all
    @agent = Agent.all
    @users = User.all
    @agents = Agent.includes(user: :daps)
    # @occurrences_since = Dap.find_by(user_id: @users.ids) 
  end

  # GET /agents/1
  def show
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
    
@occurrences_since = Dap.find(@agent.user_id)   
  end

  # GET /agents/new
  def new
    @agent = Agent.new
  #  @departments = Department.new
  end

  # GET /agents/1/edit
  def edit
  end

  # POST /agents
  def create
    @agent = Agent.new(agent_params)
    #puts @agent.inspect
    #puts agent_params.inspect
    # puts @agent.department_id = agent_params[:dept]
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
    @agent.destroy
    redirect_to agents_url, notice: 'Agent was successfully destroyed.'
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
      params.require(:agent).permit(:id, :fname, :lname, :hire, :dept, :department_id, user: [:full_name], occurrence: [:ovalue])
    end
  
    def department_params
      params.require(:department).permit(:id, :desc, :name, :foreign_key)
    end
end
