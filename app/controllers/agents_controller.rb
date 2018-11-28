class AgentsController < ApplicationController
  layout "scaffold"

  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  def index
    @agents = Agent.all
    # @department = Department.find(@agent.all.includes(:Departments))

  end

  # GET /agents/1
  def show
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
      params.require(:agent).permit(:id, :fname, :lname, :hire, :dept, :department_id)
    end
  
    def department_params
      params.require(:department).permit(:id, :desc, :name, :foreign_key)
    end
end
