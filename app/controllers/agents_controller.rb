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
      @agents = Agent.index_controller
    else
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    end
    @entries = Entry.all.stats.includes(agent: [:user, :department], occurrence: params[:ovalue]).paginate(page: params[:page], :per_page => 5) # keep for now
    respond_to do |format|
      format.html
      format.json {render :json => @agents}
    end
  end

  def agent_breakdown
    @agents = Agent.index_controller
    agent_array = Array.new
    @agents.each do |agent| 
       if agent.user.deleted_at.nil? && agent.user.has_role?(:agent) || agent.user.has_role?(:lead) || agent.user.has_role?(:reporting) 
        agent_array << {
          'Full Name': agent.user.full_name, 
          'Email': agent.user.email, 
          'Department': agent.department.name.truncate(15), 
          'TAO': if agent.entries.map {|a| a.total_effective_occurrence.to_f}.first.to_f > 2.5 
                agent.entries.map {|a| a.total_effective_occurrence.to_f}.first
               else 
                agent.entries.map {|a| a.total_effective_occurrence.to_f}.first
               end, 
          'TAW': if agent.user.daps.map {|m| m.total_active_writeup.to_f}.join(' ').to_f > 0 
                 agent.user.daps.map {|m| m.total_active_writeup.to_f}.join(' ').to_i
               else 
                 agent.user.daps.map {|m| m.total_active_writeup.to_i}.join(' ').to_f
               end, 
          'OSAW': if agent.user.daps.map {|m| m.occurrence_since_dap}.first.to_f >= 1.0 
                 agent.user.daps.map{|m| m.occurrence_since_dap}.first
               else 
                 agent.user.daps.map{|m| m.occurrence_since_dap}.first
               end, 
            'OSW': if agent.user.daps.map {|m| m.total_occurrences_since_writeup.to_f}.first.to_f > 2.5 
                   agent.user.daps.map {|m| m.total_occurrences_since_writeup.to_f}.first
                 else 
                   agent.user.daps.map {|m| m.total_occurrences_since_writeup.to_f}.first
                 end, 
            'AR': if agent.user.daps.map {|m| m.occurrence_since_dap}.first.to_f >= 1.0 || agent.entries.map {|a| a.total_effective_occurrence}.first.to_f > 2.5 && agent.user.daps.map.count {|m| m.total_active_writeup} == 0 || agent.user.daps.map {|m| m.total_occurrences_since_writeup.to_f}.first.to_f > 2.5 
                  "<i class='fa fa-times-circle text-danger'></i>"
                 else 
                  "<i class='fa fa-check-circle text-success'></i>"
                 end, 
            '': ("<div class='btn-group'> " + helpers.link_to(helpers.theme_icon_tag('eye'), agent_path(agent.id), 'data-toggle': 'tooltip', title: 'Show', class: 'btn btn-link') + helpers.link_to(helpers.theme_icon_tag('pencil-alt'), edit_user_path(agent.user.id), 'data-toggle': 'tooltip', title: 'Edit', class: 'btn btn-link') + helpers.link_to(helpers.theme_icon_tag('trash'), user_path(agent.user.id), confirm: 'Are you sure?', method: :delete, data: { confirm: 'Are you sure?' }, method: :delete, class: 'btn btn-link') + "</div>")
        }
         else 
       end 
     end 
    respond_to do |format|
      format.html
      format.json {render :json => agent_array}
    end
  end

  def new_entry
    @entry = Entry.new
  end

  def new_writeup
    @dap = Dap.new
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
      params.require(:agent).permit(:id, :fname, :lname, :hire, :dept, :department_id, :role, user: [:full_name], occurrence: [:ovalue], agent: [:id])
    end
  
    def department_params
      params.require(:department).permit(:id, :desc, :name, :foreign_key)
    end
end
