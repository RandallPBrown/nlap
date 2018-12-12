

class EntriesController < ApplicationController
  layout "scaffold"

  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def dashboard
    require 'date'
    @body_class = "with-sidebar show-sidebar"
    @entries = Entry.all.includes(occurrence: params[:ovalue])
    @occurrence_total = Entry.joins(:occurrence).sum(:ovalue)
    @occurrence_total_today = Entry.today.joins(:occurrence).sum(:ovalue)
    @occurrenceval = Entry.all.map {|m| m.occurrence}
    @entries = Entry.all.order(created_at: :desc).paginate(page: params[:page], :per_page => 5)
    @agent_total_today = Entry.today.joins(:agent).count(:id)
    # to filter by today, use .where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @chart_data_effective = Entry.effective.joins(:occurrence, agent: :department).group('departments.name').order('departments.name asc').sum(:ovalue).values
    @chart_labels_effective = Entry.effective.joins(:occurrence, agent: :department).group('departments.name').order('departments.name asc').pluck('departments.name')
    @chart_data_today = Entry.today.joins(:occurrence, agent: :department).group('departments.name').order('departments.name asc').sum(:ovalue).values
    @chart_labels_today = Entry.today.joins(:occurrence, agent: :department).group('departments.name').order('departments.name asc').pluck('departments.name').to_s  
    @chart_data_agent_today = Entry.today.joins(:occurrence, agent: :user).group('users.email').order('users.email asc').sum(:ovalue).values
    @chart_labels_agent_today = Entry.today.joins(:occurrence, agent: :user).group('users.email').order('users.email asc').pluck('users.email').to_s  
    @chart_data_agent_effective = Entry.effective.joins(:occurrence, agent: :user).group('users.email').order('users.email asc').sum(:ovalue).values
    @chart_labels_agent_effective = Entry.effective.joins(:occurrence, agent: :user).group('users.email').order('users.email asc').pluck('users.email').to_s  

  end

  def _most_active_users
    @entries = Entry.all.paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'
  end

  # GET /entries
  def index
    @entries = Entry.all.order(created_at: :desc).paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'

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
      params.require(:entry).permit(:agent_id, :dept, :occurrence_id, :edate, :edesc, occurrence: [:ovalue])
    end
end
