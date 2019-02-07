class ErrLogsController < ApplicationController
  layout "scaffold"

  before_action :set_err_log, only: [:show, :edit, :update, :destroy]

  # GET /err_logs
  def index
    @err_logs = ErrLog.all
  end

  # GET /err_logs/1
  def show
  end

  # GET /err_logs/new
  def new
    @err_log = ErrLog.new
  end

  # GET /err_logs/1/edit
  def edit
  end

  # POST /err_logs
  def create
    @err_log = ErrLog.new(err_log_params)

    if @err_log.save
      redirect_to @err_log, notice: 'Err log was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /err_logs/1
  def update
    if @err_log.update(err_log_params)
      redirect_to @err_log, notice: 'Err log was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /err_logs/1
  def destroy
    @err_log.destroy
    redirect_to err_logs_url, notice: 'Err log was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_err_log
      @err_log = ErrLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def err_log_params
      params.require(:err_log).permit(:user_id, :department_id, :errdate, :err_name_id, :errdesc, :err_status_id, :errsubmitby)
    end
end
