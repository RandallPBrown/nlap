class IncentivesController < ApplicationController
  layout "scaffold"
  before_action :authorize_admin
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_incentive, only: [:show, :edit, :update, :destroy]

  # GET /incentives
  def index
    @incentives = Incentive.all.joins(:user)
  end

  def import
    @errors = ErrLog.joins(:err_status, :err_name).includes(:err_status, :err_name).where('user_id = ?', current_user.id).select(:err_names).where('err_names.errname = ?', 'Improvement Opportunity').where(errdate: Date.current.beginning_of_month...Date.today).count
      csv_file = params[:file].read
      CSV.parse(csv_file) do |row|
      incentives = Incentive.create(user_id: row[0], uph: row[1], occupancy: row[2], date: row[3], aht: row[4], turntime: row[5], error_amount: row[6], contracts: row[7])
      incentives.save
    end
    redirect_to incentives_path, notice: "Que added"
  end

  # GET /incentives/1
  def show
  end

  # GET /incentives/new
  def new
    @incentive = Incentive.new
  end

  # GET /incentives/1/edit
  def edit
  end

  # POST /incentives
  def create
    @incentive = Incentive.new(incentive_params)

    if @incentive.save
      redirect_to @incentive, notice: 'Incentive was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /incentives/1
  def update
    if @incentive.update(incentive_params)
      redirect_to @incentive, notice: 'Incentive was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /incentives/1
  def destroy
    @incentive.destroy
    redirect_to incentives_url, notice: 'Incentive was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incentive
      @incentive = Incentive.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def incentive_params
      params.require(:incentive).permit(:user_id, :uph, :quality, :improvement_opp, :occupancy, :turntime, :error_amount, :contracts, :aht)
    end
end
