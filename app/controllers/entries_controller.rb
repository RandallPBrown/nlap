
require 'csv'
require 'pusher'

class EntriesController < ApplicationController
  before_action :authorize_admin, except: [:show]
  before_action :authenticate_user!
  layout "scaffold"

  before_action :set_entry, only: [:show, :edit, :update, :destroy]



  def dashboard
    require 'date'
    @entry = Entry.new
    @dap = Dap.new
    @err_log = ErrLog.new
    @asdf = helpers.current_user.roles.map {|f|f.name}.first
    @body_class = "with-sidebar show-sidebar" #system generated
    @current_department = current_user.department.name # keep for now
    @entries = Entry.all.joins(agent: :user).order(updated_at: :desc).includes(agent: [:user, :department], occurrence: params[:ovalue]).paginate(page: params[:page], :per_page => 5) # keep for now
    case helpers.current_user.roles.map {|f|f.name}.first
    when 'executive'
      #Dan/dad/rick
           @chart_data_dept_today = Entry.today.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: :user).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').sum(:ovalue)
           @chart_data_agent_today = Entry.today.grouped_user.order('users.first_name asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.order('users.first_name asc').pluck('users.first_name', 'users.last_name').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.order('users.first_name asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.order('users.first_name asc').pluck('users.first_name', 'users.last_name').to_s  
    when 'director'
        #Aubrey
        if @current_department.eql? "Contact Center"
            query1 'Ferguson', 'Service-Contract'
        elsif @current_department.eql? "Back Office"
        #Adrian
            then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").sum(:ovalue)
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.first_name asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.first_name asc').pluck('users.first_name', 'users.last_name').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.first_name asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.first_name asc').pluck('users.first_name', 'users.last_name').to_s  
        end
    when 'manager'
      #missy
      
      if @current_department.eql? "Back Office"
        query1 'Claims', 'Service-Network'
      elsif @current_department.eql? "Contact Center"
        query1  'Ferguson', 'Service-Contract'  
      end
    when 'supervisor'
      #Juan
      if @current_department.eql? 'Ferguson'
        query1  'Ferguson', 'Service-Contract'
      elsif @current_department.eql? "Approvals"
        query1  'Pre-Approvals', 'Pending-Review'  
      end
    else
        #regular agents
        @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').sum(:ovalue).values
        @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').pluck('departments.name').to_s
        @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').sum(:ovalue).values
        @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').pluck('departments.name').to_s
        if current_user.has_role?(:lead) 
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).where('departments.name = ?', @current_department).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').sum(:ovalue)            
        else
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: :user).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').sum(:ovalue)           
        end
    end





    @chart_data_effective = Entry.effective.grouped_dept.order('departments.name asc').sum(:ovalue).values
    @chart_labels_effective = Entry.effective.grouped_dept.order('departments.name asc').pluck('departments.name')
    @chart_data_today = Entry.today.grouped_dept.order('departments.name asc').sum(:ovalue).values
    @chart_labels_today = Entry.today.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
  end

    def query1 (param1, param2)
        #dry
        @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', param1, param2).order('departments.name asc').sum(:ovalue).values
        @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', param1, param2).order('departments.name asc').pluck('departments.name').to_s  
        @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', param1, param2).order('departments.name asc').sum(:ovalue).values
        @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', param1, param2).order('departments.name asc').pluck('departments.name').to_s  
        @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order("users.first_name, users.last_name").sum(:ovalue)
        @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', param1, param2).order('users.first_name asc').sum(:ovalue).values
        @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', param1, param2).order('users.first_name asc').pluck('users.first_name', 'users.last_name').to_s  
        @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', param1, param2).order('users.first_name asc').sum(:ovalue).values
        @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', param1, param2).order('users.first_name asc').pluck('users.first_name', 'users.last_name').to_s  

        return @chart_data_dept_today, @chart_labels_dept_today, @chart_data_dept_effective, @chart_labels_dept_effective, @agent_occurrence_values, @chart_data_agent_today, @chart_labels_agent_today, @chart_data_agent_effective, @chart_labels_agent_effective
    end

  def _most_active_users
    @entries = Entry.all.paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'
  end

  def my_results
    @results = Entry.all.joins(:agent, :occurrence)
    respond_to do |format|
      format.html
      format.csv { send_data @results.to_csv, filename: "entries-#{Date.today}.csv" }
    end
  end

def agentview
  @users = User.all
  @user = User.find(params[:id])
  @daps_count = Dap.written.joins(:user).where("users.id = ?", @user.id).count
  @entries_count = Entry.effective.joins(:occurrence, agent: :user).group(:edate).where("users.id = ?", @user.id).group(:ovalue).pluck(:ovalue).sum
  @entries_count_dates = Entry.effective.joins(:occurrence, agent: :user).group(:edate).where("users.id = ?", @user.id).group(:edate).pluck(:edate)
  @dap_last = Dap.written.joins(:user).where("users.id = ?", @user.id).group('daps.id').group(:ddate).pluck(:ddate)
  if @dap_last.present?
        @entries_since_dap = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @user.id).group(:edate).where(edate: @dap_last.last.end_of_day...Date.today.end_of_day).group(:ovalue).pluck(:ovalue)
        @entries_since_dap_dates = Entry.effective.joins(:occurrence, agent: :user).where("users.id = ?", @user.id).group(:edate).where(edate: @dap_last.last.end_of_day...Date.today.end_of_day).group(:edate).pluck(:edate)

  else
        @entries_since_dap = [0,0]
        @entries_since_dap_dates = ["none"]
  end
  respond_to do |format|
    format.html
    format.js
    
  end
end

  # GET /entries
  def index
    @entries = Entry.all.joins(:department, :occurrence, agent: :user).order('edate desc').includes(:user, :department, :occurrence)
    @agents_list = Agent.all.order(params[:sort]).includes(:entries, :user)
    @entry = Entry.new
  end

  def entry_breakdown
    @entries = Entry.all.joins(:department, :occurrence, agent: :user).order(params[:sort]).order('edate desc').includes(:user, :department, :occurrence)
    entry_array = Array.new
    @entries.each do |entry| 
      if entry.user.deleted_at.nil? 
        entry_array << {'Agent': entry.user.full_name, 
         'Department': entry.department.name.truncate(15), 
         'Occurrence': entry.occurrence.name.truncate(12), 
         'Value': entry.occurrence.ovalue, 
         'Date': entry.edate, 
         'Expiration': entry.edate + 90.days, 
         'Description': entry.edesc.truncate(10), 
         '': (helpers.link_to(helpers.theme_icon_tag('eye'), entry, 'data-toggle': 'tooltip', title: 'Show', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('pencil-alt'), edit_entry_path(entry), 'data-toggle': 'tooltip', title: 'Edit', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('trash'), entry, 'data-toggle': 'tooltip', title: 'Delete', method: :delete, class: 'btn btn-link p-1'))}
       else 
      end  
    end 
    respond_to do |format|
      format.html
      format.json {render :json => entry_array, public: true}
    end
  end


  # GET /entries/1
  def show
    if current_user.has_role?(:agent) && (@entry.agent.user_id != current_user.id) then
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    elsif current_user.has_role?(:agent) && (@entry.agent.user_id = current_user.id)
      @user_entry = Entry.includes(:agent, :occurrence).occurrence_user.group('agents.id', 'occurrences.id')
        .where("users.id = ?", @entry.agent.user.id)
        .group(:id).order("entries.edate DESC")
        .paginate(page: params[:page], :per_page => 3)
      @user_dap = Dap.joins(:writeup, :user)
        .where("users.id = ?", @entry.agent.user.id)
        .group(:id).order("daps.ddate DESC")
        .paginate(page: params[:page], :per_page => 3)
      # respond_to do |format|
      #   format.html
      #   format.pdf do
      #     render  pdf: "OCCURRENCE-#{current_user.full_name}-#{Date.today}"
      #   end
      # end
    elsif current_user.has_role?(:reporting) || current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @user_entry = Entry.occurrence_user
        .where("users.id = ?", @entry.agent.user.id)
        .group(:id).order("entries.edate DESC")
        .paginate(page: params[:page], :per_page => 3)
      @user_dap = Dap.joins(:writeup, :user)
        .where("users.id = ?", @entry.agent.user.id)
        .group(:id).order("daps.ddate DESC")
        .paginate(page: params[:page], :per_page => 3)
    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     render  pdf: "OCCURRENCE-#{current_user.full_name}-#{Date.today}"
    #   end
    # end
  end
end


  def calendar
    if current_user.has_role?(:reporting) || current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @entry = Entry.new
      @entries = Entry.joins(:occurrence).where("occurrences.name = ?", "Vacation")
    else
      redirect_to entries_path, notice: 'Unauthorized'
    end
  end

  def agent_list
    if current_user.has_role?(:reporting) || current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @entry = Entry.all
      @agents_list = Agent.order('users.first_name ASC').includes(:entries, user: :daps)
    else
      redirect_to entries_path, notice: 'Unauthorized'
    end
  end

  # GET /entries/new
  def new
    if current_user.has_role?(:reporting) || current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @entry = Entry.new
      @department = Entry.joins(agent: :department)
      @user = Entry.joins(agent: :user).group('users.email')
    else
      redirect_to entries_path, notice: 'Unauthorized'
    end  
  end

  # GET /entries/1/edit
  def edit
    if current_user.has_role?(:reporting) || current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then

    else
      redirect_to entries_path, notice: 'Unauthorized'
    end
  end

  # POST /entries
  def create
      @entry = Entry.new(entry_params)
      @user = Entry.joins(agent: :user).group('users.email')
      if @entry.save
        # EntryMailer.entry_email(@entry).deliver_now
        # redirect_to @entry, notice: 'Entry was successfully created.'
          pusher_client = Pusher::Client.new(
            app_id: ENV["PUSHER_APP_ID"],
            key: ENV["PUSHER_KEY"],
            secret: ENV["PUSHER_SECRET"],
            cluster: ENV["PUSHER_CLUSTER"],
            encrypted: true
          )
        pusher_client.trigger('entry', 'new-entry', {
            agent: @entry.user.full_name,
            department: @entry.user.department.name,
            occurrence: @entry.occurrence.name,
            ovalue: @entry.occurrence.ovalue,
            date: @entry.edate,
            exp: @entry.edate + 90.days,
            description: @entry.edesc,
            id: @entry.user.id
        })
        redirect_back(fallback_location: root_path)
        flash[:notice] = 'Occurrence has been logged successfully'
      else
        render :new
      end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      redirect_back(fallback_location: root_path)
      flash[:notice] = 'Occurrence has been updated successfully'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @entry.destroy
      redirect_to entries_url, notice: 'Entry was successfully destroyed.'
    else
      redirect_to entries_url, notice: 'unauthorized'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def sort_column
      Entry.column_names.include?(params[:sort]) ? params[:sort] : "edate"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def sort_column
      Agent.column_names.include?(params[:sort]) ? params[:sort] : "desc"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.require(:entry).permit(:query, :agent_id, :dept, :occurrence_id, :edate, :edesc, occurrence: [:ovalue])
    end
end
