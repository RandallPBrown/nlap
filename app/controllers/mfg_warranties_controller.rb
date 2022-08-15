class MfgWarrantiesController < ApplicationController
  layout "scaffold"

  before_action :set_mfg_warranty, only: [:show, :edit, :update, :destroy]

  # GET /mfg_warranties
  def index
    @mfg_warranties = MfgWarranty.all
  end

  # GET /mfg_warranties/1
  def show
  end

  # GET /mfg_warranties/new
  def new
    @mfg_warranty = MfgWarranty.new
  end

  # GET /mfg_warranties/1/edit
  def edit
  end

  # POST /mfg_warranties
  def create
    @mfg_warranty = MfgWarranty.new(mfg_warranty_params)

    if @mfg_warranty.save
      # redirect_to @mfg_warranty, notice: 'Mfg warranty was successfully created.'
        respond_to do |format|
          format.html 
          format.js 
        end
    else
      render :new
    end
  end

  # PATCH/PUT /mfg_warranties/1
  def update
    if @mfg_warranty.update(mfg_warranty_params)
      redirect_to @mfg_warranty, notice: 'Mfg warranty was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mfg_warranties/1
  def destroy
    @mfg_warranty.destroy
    redirect_to mfg_warranties_url, notice: 'Mfg warranty was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mfg_warranty
      @mfg_warranty = MfgWarranty.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mfg_warranty_params
      params.require(:mfg_warranty).permit(:dop, :model_number, :warranty_link, :manufacturer)
    end
end
