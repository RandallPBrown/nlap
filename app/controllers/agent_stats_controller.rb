class AgentStatsController < ApplicationController
  layout "scaffold"

  before_action :set_agent_stat, only: [:show, :edit, :update, :destroy]

  # GET /agent_stats
  def index
    require 'will_paginate/array'
    @agent_stats = AgentStat.all
    @agent_stat_count = AgentStat.all.count(:id).to_i
  end

  def all_stats
    @agent_stats = AgentStat.all
  end

  # GET /agent_stats/1
  def show
  end

  def csv_upload
    @agent_stat = AgentStat.new(agent_stat_params_upload)
    @test = User.where(extension: params[:extension]).pluck(:id)
    if @test.present?
      @agent_stat.user_id = @test.first
    else 
      @agent_stat.user_id = "unknown"
    end
    @agent_stat.save
  end


  # GET /agent_stats/new
  def new
    @agent_stat = AgentStat.new
        @agent_stats = AgentStat.all
    @agent_stat_count = AgentStat.all.count(:id).to_i
  end

  # GET /agent_stats/1/edit
  def edit
  end

  # POST /agent_stats
  def create
    @agent_stat = AgentStat.new(agent_stat_params)

    if @agent_stat.save
      redirect_to @agent_stat, notice: 'Agent stat was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /agent_stats/1
  def update
    if @agent_stat.update(agent_stat_params)
      redirect_to @agent_stat, notice: 'Agent stat was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /agent_stats/1
  def destroy
    @agent_stat.destroy
    redirect_to agent_stats_url, notice: 'Agent stat was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent_stat
      @agent_stat = AgentStat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def agent_stat_params
      params.require(:agent_stat).permit(:extension, :name, :date, :shift, :total_login, :total_break, :net_login, :requested_worktime, :availability, :occupancy, :queue_calls, :queue_talk, :direct_calls, :direct_talk, :outbound_calls, :outbound_talk, :callback_calls, :callback_talk, :deleted, :un_ans, :picked, :recover, :power_dial, :acw, :wrapup_time, :total_calls, :total_talk, :aht)
    end

    def agent_stat_params_upload
      params.permit(:user_id, :extension, :abnd, :name, :date, :shift, :total_login, :total_break, :net_login, :requested_worktime, :availability, :occupancy, :queue_calls, :queue_talk, :direct_calls, :direct_talk, :outbound_calls, :outbound_talk, :callback_calls, :callback_talk, :deleted, :un_ans, :picked, :recover, :power_dial, :acw, :wrapup_time, :total_calls, :total_talk, :aht)
    end
end
