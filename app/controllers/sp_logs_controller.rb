class SpLogsController < ApplicationController
  layout "scaffold"

  before_action :set_sp_log, only: [:show, :edit, :update, :destroy]

  # GET /sp_logs
  def index
    @sp_logs = SpLog.all
  end

  def import
    @sp_logs = SpLog.all
      csv_file = params[:file].read
      CSV.parse(csv_file) do |row|
      sp_logs = SpLog.create(name: row[0], phone: row[1], state: row[2], email: row[3], notes: row[4], sp_log_type_id: row[5])
      sp_logs.save
    end
    redirect_to :back, notice: "Imported successfully"
  end

  # GET /sp_logs/1
  def show
  end

  # GET /sp_logs/new
  def new
    @sp_log = SpLog.new
  end

  # GET /sp_logs/1/edit
  def edit
  end

  # POST /sp_logs
  def create
    @sp_log = SpLog.new(sp_log_params)

    if @sp_log.save
      redirect_to @sp_log, notice: 'Sp log was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sp_logs/1
  def update
    if @sp_log.update(sp_log_params)
      redirect_to @sp_log, notice: 'Sp log was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sp_logs/1
  def destroy
    @sp_log.destroy
    redirect_to sp_logs_url, notice: 'Sp log was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sp_log
      @sp_log = SpLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sp_log_params
      params.require(:sp_log).permit(:name, :phone, :state, :email, :notes, :sp_log_type_id)
    end
end
