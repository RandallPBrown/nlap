
require 'csv'

class EntriesController < ApplicationController
  before_action :authorize_admin, except: [:show]
  before_action :authenticate_user!
  layout "scaffold"

  before_action :set_entry, only: [:show, :edit, :update, :destroy]


  def dashboard
    require 'date'
    
    @body_class = "with-sidebar show-sidebar"
    @current_department = current_user.department.name
    @entries = Entry.all.includes(occurrence: params[:ovalue]).joins(agent: :user).order(updated_at: :desc).paginate(page: params[:page], :per_page => 5)
    @occurrence_total = Entry.joins(:occurrence).sum(:ovalue)
    @occurrence_total_today = Entry.today.joins(:occurrence).sum(:ovalue)
    @occurrenceval = Entry.all.map {|m| m.occurrence}
    # @entries = Entry.all.order(updated_at: :desc).paginate(page: params[:page], :per_page => 5)
    @agent_total_today = Entry.today.joins(:agent).count(:id)
    # to filter by today, use .where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    if @current_department.eql? "Executive"
      #Dan/dad/rick
      then @chart_data_dept_today = Entry.today.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").order("users.first_name, users.last_name").sum(:ovalue).values
           @agent_occurrence_labels = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @chart_data_agent_today = Entry.today.grouped_user.order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Call Center Director"
      #Aubrey
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order("users.first_name, users.last_name").sum(:ovalue).values
           @agent_occurrence_labels = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Back Office Director"
      #Adrian
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").sum(:ovalue).values
           @agent_occurrence_labels = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Claims/Service Network Supervisor"
      #missy
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order("users.first_name, users.last_name").sum(:ovalue).values
           @agent_occurrence_labels = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Pre-Approval/Pending-Review Supervisor"
      #Juan
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").sum(:ovalue).values
           @agent_occurrence_labels = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('users.email asc').pluck('users.email').to_s  
    else 
      #regular agents
           @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').pluck('departments.name').to_s
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').pluck('departments.name').to_s
           @agent_occurrence_values = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ?', @current_department).order("users.first_name, users.last_name").sum(:ovalue).values
           @agent_occurrence_labels = Entry.all.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ?', @current_department).order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
    end

    @chart_data_effective = Entry.effective.grouped_dept.order('departments.name asc').sum(:ovalue).values
    @chart_labels_effective = Entry.effective.grouped_dept.order('departments.name asc').pluck('departments.name')
    @chart_data_today = Entry.today.grouped_dept.order('departments.name asc').sum(:ovalue).values
    @chart_labels_today = Entry.today.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
  end

  def _most_active_users
    @entries = Entry.all.paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'
  end

  def my_results
    @results = Entry.all
    respond_to do |format|
      format.html
      format.csv { send_data @results.to_csv }
    end
  end

  # GET /entries
  def index
    require 'will_paginate/array'
    if params[:search].present?
      @entries = Entry.order(edate: :desc).perform_search(params[:search]).paginate(page: params[:page], :per_page => 5)
    else
      @entries = Entry.all.joins(:department, :occurrence, agent: :user).order(params[:sort]).paginate(page: params[:page], :per_page => 5)
    end
    @agents_list = Agent.all.includes(:entries, :user).order(params[:sort])
  end


  # GET /entries/1
  def show
    @user_entry = Entry.occurrence_user
      .where("users.id = ?", @entry.agent.user.id)
      .group(:id).order("entries.edate DESC")
      .paginate(page: params[:page], :per_page => 3)
    @user_dap = Dap.joins(:writeup, :user)
      .where("users.id = ?", @entry.agent.user.id)
      .group(:id).order("daps.ddate DESC")
      .paginate(page: params[:page], :per_page => 3)
      respond_to do |format|
  format.html
  format.pdf do
    render  pdf: "your-filename"
  end
end
  end

  def calendar
    @entry = Entry.new
    if params[:search].present?
      @entries = Entry.perform_search(params[:search]).order(edate: :desc).paginate(page: params[:page], :per_page => 5)
    else
      @entries = Entry.all
    end
  end

  def agent_list
    @entry = Entry.all
    @agents_list = Agent.includes(:entries, user: :daps).order('users.first_name ASC')
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @department = Entry.joins(agent: :department)
    @user = Entry.joins(agent: :user).group('users.email')
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  def create
    @entry = Entry.new(entry_params)
    @user = Entry.joins(agent: :user).group('users.email')
    if @entry.save
      # redirect_to @entry, notice: 'Entry was successfully created.'
      redirect_to '/entries', notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
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
