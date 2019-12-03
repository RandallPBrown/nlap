class IncentiveSettingsController < ApplicationController
  layout "scaffold"

  before_action :set_incentive_setting, only: [:show, :edit, :update, :destroy]

  # GET /incentive_settings
  def index
    @incentive_settings = IncentiveSetting.all
  end

  # GET /incentive_settings/1
  def show
  end

  # GET /incentive_settings/new
  def new
    @incentive_setting = IncentiveSetting.new
  end

  # GET /incentive_settings/1/edit
  def edit
  end

  # POST /incentive_settings
  def create
    @incentive_setting = IncentiveSetting.new(incentive_setting_params)

    if @incentive_setting.save
      redirect_to @incentive_setting, notice: 'Incentive setting was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /incentive_settings/1
  def update
    if @incentive_setting.update(incentive_setting_params)
      redirect_to @incentive_setting, notice: 'Incentive setting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /incentive_settings/1
  def destroy
    @incentive_setting.destroy
    redirect_to incentive_settings_url, notice: 'Incentive setting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incentive_setting
      @incentive_setting = IncentiveSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def incentive_setting_params
      params.require(:incentive_setting).permit(:occupancy, :uph, :attendance, :quality, :error, :error_amount, :turntime, :contracts, :department_id)
    end
end
