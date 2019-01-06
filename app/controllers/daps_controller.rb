class DapsController < ApplicationController
  layout "scaffold"
  
  before_action :set_dap, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:show]

  # GET /daps
  def index
    # @daps = Dap.all.paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'
    if params[:search].present?
      @daps = Dap.perform_search(params[:search]).order(ddate: :desc).paginate(page: params[:page], :per_page => 5)
    else
      @daps = Dap.all.order(ddate: :desc).paginate(page: params[:page], :per_page => 5)
    end
  end


  # GET /daps/1
  def show
    @future_time = @dap.ddate + 90.days
    @daps = Dap.all.joins(:user).where('user_id = ?', @dap.user_id)
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "your-filename",
      end
    end
  end

  # GET /daps/new
  def new
    @dap = Dap.new
  end

  # GET /daps/1/edit
  def edit
  end

  # POST /daps
  def create
    @dap = Dap.new(dap_params)

    if @dap.save
      redirect_to @dap, notice: 'Dap was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /daps/1
  def update
    if @dap.update(dap_params)
      redirect_to @dap, notice: 'Dap was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /daps/1
  def destroy
    @dap.destroy
    redirect_to daps_url, notice: 'Dap was successfully destroyed.'
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
