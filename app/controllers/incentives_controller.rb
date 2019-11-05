class IncentivesController < ApplicationController
  layout "scaffold"

  before_action :set_incentive, only: [:show, :edit, :update, :destroy]

  # GET /incentives
  def index
    @incentives = Incentive.all.joins(:user)
  end

  def import
      csv_file = params[:file].read
      CSV.parse(csv_file) do |row|
      incentives = Incentive.create(user_id: row[0], uph: row[1], quality: row[2], improvement_opp: row[3], occupancy: row[4], date: row[5])
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
      params.require(:incentive).permit(:user_id, :uph, :quality, :improvement_opp, :occupancy)
    end
end
