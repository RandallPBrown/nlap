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
        pusher_client = Pusher::Client.new(
            app_id: ENV["PUSHER_APP_ID"],
            key: ENV["PUSHER_KEY"],
            secret: ENV["PUSHER_SECRET"],
            cluster: ENV["PUSHER_CLUSTER"],
            encrypted: true
          )
        pusher_client.trigger('ferg', 'new-ferg', {
            id: @ferguson.id,
            user_id: current_user.id ,
            district_id: @ferguson.district.name,
            so_number: @ferguson.so_number, 
            customer_name: @ferguson.customer_name, 
            sp_name: @ferguson.sp_name, 
            address: @ferguson.address, 
            manufacturer: @ferguson.manufacturer, 
            product: @ferguson.product, 
            model: @ferguson.model, 
            escalated: helpers.best_in_place(@ferguson, :escalated, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light'),
            leaking: helpers.best_in_place(@ferguson, :leaking, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light'),
            customer_fo: helpers.best_in_place(@ferguson, :customer_fo, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light'),
            dealer_fo: helpers.best_in_place(@ferguson, :servicer_fo, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light'),
            servicer_fo: helpers.best_in_place(@ferguson, :dealer_fo, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light')
        })
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
