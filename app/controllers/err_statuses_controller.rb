class ErrStatusesController < ApplicationController
  layout "scaffold"

  before_action :set_err_status, only: [:show, :edit, :update, :destroy]

  # GET /err_statuses
  def index
    @err_statuses = ErrStatus.all
  end

  # GET /err_statuses/1
  def show
  end

  # GET /err_statuses/new
  def new
    @err_status = ErrStatus.new
  end

  # GET /err_statuses/1/edit
  def edit
  end

  # POST /err_statuses
  def create
    @err_status = ErrStatus.new(err_status_params)

    if @err_status.save
      redirect_to @err_status, notice: 'Err status was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /err_statuses/1
  def update
    if @err_status.update(err_status_params)
      redirect_to @err_status, notice: 'Err status was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /err_statuses/1
  def destroy
    @err_status.destroy
    redirect_to err_statuses_url, notice: 'Err status was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_err_status
      @err_status = ErrStatus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def err_status_params
      params.require(:err_status).permit(:statusname, :errvalue)
    end
end
