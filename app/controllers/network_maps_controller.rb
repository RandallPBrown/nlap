class NetworkMapsController < ApplicationController
  layout "scaffold"

  before_action :set_network_map, only: [:show, :edit, :update, :destroy]

  # GET /network_maps
  def index
    @network_maps = NetworkMap.all


    # WORKS BUT NEED TO FIND A WAY TO ADD <ExtendedData> TAGS
    # kml = KMLFile.new
    # folder = KML::Folder.new(:name => :name)

    # NetworkMap.all.each do |name, lat, lng|
    #   folder.features << KML::Placemark.new(
    #     :name => name.name,
    #     :geometry => KML::Point.new(:coordinates => {:lat => name.latitude, :lng => name.longitude}),
    #     :description => '<br>' + name.provider_number.to_s + '<br>',
    #   )
    # end
    # kml.objects << folder
    # puts kml.render

    require 'httparty'
    url = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAf_3lQsQ2GBDCzK_QZ8U142Rg2THxUr3k&callback=initMap&libraries=places&callback=initAutocomplete'
    response = HTTParty.get(url)
    @asdf = response.parsed_response
  end

  # GET /network_maps/1
  def show
  end

  # GET /network_maps/new
  def new
    @network_map = NetworkMap.new
  end

  # GET /network_maps/1/edit
  def edit
  end

  # POST /network_maps
  def create
    @network_map = NetworkMap.new(network_map_params)

    if @network_map.save
      redirect_to @network_map, notice: 'Network map was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /network_maps/1
  def update
    if @network_map.update(network_map_params)
      redirect_to @network_map, notice: 'Network map was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /network_maps/1
  def destroy
    @network_map.destroy
    redirect_to network_maps_url, notice: 'Network map was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_map
      @network_map = NetworkMap.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def network_map_params
      params.require(:network_map).permit(:id,  :created_at,  :updated_at,  :servicerstatus,  :self_servicing,  :provider_number, :name,  :address, :phone, :fax, :contracted, :sealed_system, :rating,  :latitude,  :longitude)
    end
end
