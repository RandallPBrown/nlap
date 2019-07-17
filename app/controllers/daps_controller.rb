class DapsController < ApplicationController
  layout "scaffold"
  before_action :set_dap, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:show]
  require 'pusher'


  # GET /daps
  def index
    # @daps = Dap.all.paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'
      @daps = Dap.all.includes(:wunature, :user, :writeup)
    respond_to do |format|
      format.html
      format.json {render :json => @daps}
    end
  end


  # GET /daps/1
  def show
    if current_user.has_role?(:agent) && (@dap.user_id != current_user.id) then
      redirect_to users_dashboard_path, notice: 'Unauthorized'
    elsif current_user.has_role?(:agent) && (@dap.user_id = current_user.id)

    elsif current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @future_time = @dap.ddate + 90.days
      @daps = Dap.written.joins(:user).where('user_id = ?', @dap.user_id).where('ddate <= ?', @dap.ddate).order('ddate desc')
      @entries = Entry.effective.joins(agent: :user).where('user_id = ?', @dap.user_id).where('edate <= ?', @dap.ddate).order('edate desc')
      respond_to do |format|
        format.html
        format.pdf do
          render  pdf: "DAP-#{current_user.full_name}-#{Date.today}"
        end
      end
    else
      redirect_to users_path, notice: 'Unauthorized'
    end
  end

  # GET /daps/new
  def new
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @dap = Dap.new
    else 
      redirect_to daps_path, notice: 'Unauthorized'
    end    
  end

  # GET /daps/1/edit
  def edit
  end

  # POST /daps
  def create
      @dap = Dap.new(dap_params)

      if @dap.save
        # DapMailer.dap_email(@dap).deliver_now
        pusher_client = Pusher::Client.new(
            app_id: ENV["PUSHER_APP_ID"],
            key: ENV["PUSHER_KEY"],
            secret: ENV["PUSHER_SECRET"],
            cluster: ENV["PUSHER_CLUSTER"],
            encrypted: true
          )
        pusher_client.trigger('dap', 'new-dap', {
            noi: @dap.wunature.description,
            date: @dap.ddate,
            agent: @dap.user.full_name,
            wuname: @dap.writeup.name,
            osd: @dap.occurrence_since_dap,
            id: @dap.user.id
        })
        redirect_to @dap, notice: 'Dap was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /daps/1
  def update
    if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      if @dap.update(dap_params)
        redirect_to @dap, notice: 'Dap was successfully updated.'
      else
        render :edit
      end
    else 
      redirect_to daps_path, notice: 'Unauthorized'
    end  
  end

  # DELETE /daps/1
  def destroy
    if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @dap.destroy
      redirect_to daps_url, notice: 'Dap was successfully destroyed.'
    else 
      redirect_to daps_path, notice: 'Unauthorized'
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dap
      @dap = Dap.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dap_params
      params.require(:dap).permit(:description, :ddate, :user_id, :writeup_id, :wunature_id)
    end
end
