class FergusonsController < ApplicationController
  layout "scaffold"
  respond_to :html, :json
  before_action :set_ferguson, only: [:show, :edit, :update, :destroy]

  # GET /fergusons
  def index
    @fergusons = Ferguson.all
  end

  # GET /fergusons/1
  def show
  end

  # GET /fergusons/new
  def new
    @ferguson = Ferguson.new
  end

  # GET /fergusons/1/edit
  def edit
  end

  # POST /fergusons
  def create
    @ferguson = Ferguson.new(ferguson_params)

    if @ferguson.save
      # redirect_to @ferguson, notice: 'Ferguson was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /fergusons/1
  def update
    respond_to do |format|
      if @ferguson.update_attributes(ferguson_params)
        format.html { redirect_to(@ferguson, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@ferguson) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@ferguson) }
      end
    end
  end

  # DELETE /fergusons/1
  def destroy
    @ferguson.destroy
    redirect_to fergusons_url, notice: 'Ferguson was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ferguson
      @ferguson = Ferguson.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ferguson_params
      params.require(:ferguson).permit(:user_id, :district_id, :so_number, :customer_name, :sp_name, :address, :manufacturer, :product, :model, :escalated, :leaking, :customer_fo, :servicer_fo, :dealer_fo)
    end
end
