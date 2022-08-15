class DealersController < ApplicationController
  layout "scaffold"

  before_action :set_dealer, only: [:show, :edit, :update, :destroy]

  # GET /dealers
  def index
    @dealers = Dealer.all
  end

  # GET /dealers/1
  def show
  end

  # GET /dealers/new
  def new
    @dealer = Dealer.new
  end

  # GET /dealers/1/edit
  def edit
  end

  # POST /dealers
  def create
    @dealer = Dealer.new(dealer_params)

    if @dealer.save
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  # PATCH/PUT /dealers/1
  def update
    if @dealer.update(dealer_params)
      redirect_back(fallback_location: root_path)
    else
      render :edit
    end
  end

  # DELETE /dealers/1
  def destroy
    @dealer.destroy
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dealer
      @dealer = Dealer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dealer_params
      params.require(:dealer).permit(:buying_group_id, :appliance, :electronic, :furniture, :code, :instructions, :body_prefix, :body_suffix)
    end
end
