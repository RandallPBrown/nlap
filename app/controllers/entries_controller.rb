
require 'csv'

class EntriesController < ApplicationController
  before_action :authorize_admin, except: [:show]
  before_action :authenticate_user!
  layout "scaffold"

  before_action :set_entry, only: [:show, :edit, :update, :destroy]


  def dashboard
    require 'date'
    
    @body_class = "with-sidebar show-sidebar" #system generated
    @current_department = current_user.department.name # keep for now
    @entries = Entry.all.joins(agent: :user).order(updated_at: :desc).includes(agent: [:user, :department], occurrence: params[:ovalue]).paginate(page: params[:page], :per_page => 5) # keep for now
    if current_user.has_role?(:executive) then
      #Dan/dad/rick
           @chart_data_dept_today = Entry.today.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.order('departments.name asc').pluck('departments.name').to_s  
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: :user).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').sum(:ovalue)
           @chart_data_agent_today = Entry.today.grouped_user.order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Contact Center" || current_user.has_role?(:director)
      #Aubrey
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('departments.name asc').pluck('departments.name').to_s  
           # @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order("users.first_name, users.last_name").sum(:ovalue).values
           # @agent_occurrence_labels = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order("users.first_name, users.last_name").sum(:ovalue)
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Ferguson', 'Service-Contract').order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Back Office" || current_user.has_role?(:director)
      #Adrian
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           # @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").sum(:ovalue).values
           # @agent_occurrence_labels = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").sum(:ovalue)
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ? OR departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network', 'Pre-Approvals', 'Pending-Review').order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Back Office" || current_user.has_role?(:manager)
      #missy
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('departments.name asc').pluck('departments.name').to_s  
           # @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order("users.first_name, users.last_name").sum(:ovalue).values
           # @agent_occurrence_labels = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order("users.first_name, users.last_name").sum(:ovalue)           
           @chart_data_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_today = Entry.today.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').pluck('users.email').to_s  
           @chart_data_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').sum(:ovalue).values
           @chart_labels_agent_effective = Entry.effective.grouped_user.where('departments.name = ? OR departments.name = ?', 'Claims', 'Service-Network').order('users.email asc').pluck('users.email').to_s  
    elsif @current_department.eql? "Back Office" || current_user.has_role?(:supervisor)
      #Juan
      then @chart_data_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_today = Entry.today.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           @chart_data_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').sum(:ovalue).values
           @chart_labels_dept_effective = Entry.effective.grouped_dept.where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order('departments.name asc').pluck('departments.name').to_s  
           # @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").sum(:ovalue).values
           # @agent_occurrence_labels = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').where('departments.name = ? OR departments.name = ?', 'Pre-Approvals', 'Pending-Review').order("users.first_name, users.last_name").sum(:ovalue)                      
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
           @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: :user).where('users.deleted_at IS NULL').group('users.id', 'users.first_name', 'users.last_name').sum(:ovalue)           
           # @agent_occurrence_values = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ?', @current_department).order("users.first_name, users.last_name").sum(:ovalue).values
           # @agent_occurrence_labels = Entry.effective.joins(:occurrence, agent: [:user, :department]).group("users.first_name, users.last_name").where('departments.name = ?', @current_department).order("users.first_name, users.last_name").pluck("users.first_name, users.last_name")
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
      @entries = Entry.all.joins(:department, :occurrence, agent: :user).order(params[:sort]).order('edate desc').includes(:user, :department, :occurrence)
    @agents_list = Agent.all.order(params[:sort]).includes(:entries, :user)
    respond_to do |format|
      format.html
      format.json {render :json => @entries}
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
      if params[:search].present?
        @entries = Entry.perform_search(params[:search]).order(edate: :desc).paginate(page: params[:page], :per_page => 5)
      else
        @entries = Entry.all
      end
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
