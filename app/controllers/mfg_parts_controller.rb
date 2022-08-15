class MfgPartsController < ApplicationController
  layout "scaffold"

  before_action :set_mfg_part, only: [:show, :edit, :update, :destroy]

  # GET /mfg_parts
  def index
    @mfg_parts = MfgPart.all
  end

  # GET /mfg_parts/1
  def show
  end

  # GET /mfg_parts/new
  def new
    @mfg_part = MfgPart.new
  end

  # GET /mfg_parts/1/edit
  def edit
  end

  # POST /mfg_parts
  def create
    @mfg_part = MfgPart.new(mfg_part_params)

    if @mfg_part.save
      redirect_to @mfg_part, notice: 'Mfg part was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mfg_parts/1
  def update
    if @mfg_part.update(mfg_part_params)
      redirect_to @mfg_part, notice: 'Mfg part was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mfg_parts/1
  def destroy
    @mfg_part.destroy
    redirect_to mfg_parts_url, notice: 'Mfg part was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mfg_part
      @mfg_part = MfgPart.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mfg_part_params
      params.require(:mfg_part).permit(:part_name, :part_number, :manufacturer_id)
    end
end
