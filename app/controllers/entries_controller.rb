

class EntriesController < ApplicationController
  before_action :authorize_admin, except: [:show]
  before_action :authenticate_user!
  layout "scaffold"

  before_action :set_entry, only: [:show, :edit, :update, :destroy]


  def dashboard
    require 'date'
    
    @body_class = "with-sidebar show-sidebar"
    @current_department = current_user.department.name
    @entries = Entry.all.includes(occurrence: params[:ovalue])
    @occurrence_total = Entry.joins(:occurrence).sum(:ovalue)
    @occurrence_total_today = Entry.today.joins(:occurrence).sum(:ovalue)
    @occurrenceval = Entry.all.map {|m| m.occurrence}
    @entries = Entry.all.order(updated_at: :desc).paginate(page: params[:page], :per_page => 5)
    @agent_total_today = Entry.today.joins(:agent).count(:id)
    # to filter by today, use .where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    if @current_department.eql? "Executive"
      then @chart_data_dept_today = Entry.today.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
    elsif @current_department.eql? "Call Center Director"
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').pluck('departments.name').to_s  
    elsif @current_department.eql? "Back Office Director"
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
    elsif @current_department.eql? "Claims/Service Network Supervisor"
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').pluck('departments.name').to_s  
    elsif @current_department.eql? "Pre-Approval/Pending-Review Supervisor"
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
    else 
           @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').pluck('departments.name').to_s
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ?', @current_department).order('departments.name asc').pluck('departments.name').to_s
    end

    @chart_data_effective = Entry.effective.grouped_dept.order('departments.name asc').sum(:ovalue).values
    @chart_labels_effective = Entry.effective.grouped_dept.order('departments.name asc').pluck('departments.name')
    @chart_data_today = Entry.today.grouped_dept.order('departments.name asc').sum(:ovalue).values
    @chart_labels_today = Entry.today.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
    @chart_data_agent_today = Entry.today.grouped_user.order('users.email asc').sum(:ovalue).values
    @chart_labels_agent_today = Entry.today.grouped_user.order('users.email asc').pluck('users.email').to_s  
    @chart_data_agent_effective = Entry.effective.grouped_user.order('users.email asc').sum(:ovalue).values
    @chart_labels_agent_effective = Entry.effective.grouped_user.order('users.email asc').pluck('users.email').to_s  
    @agent_occurrence_values = Entry.all.joins(:occurrence, agent: :user).group("users.first_name, users.last_name").order("users.first_name, users.last_name").sum(:ovalue).values
    @agent_occurrence_labels = Entry.all.joins(:occurrence, agent: :user).group("users.first_name, users.last_name").order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
  end

  def _most_active_users
    @entries = Entry.all.paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'
  end

  # GET /entries
  def index
    # @entries = Entry.all.order(created_at: :desc).paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'
    if params[:search].present?
      @entries = Entry.perform_search(params[:search]).order(edate: :desc).paginate(page: params[:page], :per_page => 5)
    else
      @entries = Entry.all.order(edate: :desc).paginate(page: params[:page], :per_page => 5)
    end
  end

  # GET /entries/1
  def show
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
      redirect_to @entry, notice: 'Entry was successfully created.'
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

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.require(:entry).permit(:query, :agent_id, :dept, :occurrence_id, :edate, :edesc, occurrence: [:ovalue])
    end
end
