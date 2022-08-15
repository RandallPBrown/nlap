class WunaturesController < ApplicationController
  layout "scaffold"
  before_action :authorize_admin
  before_action :authenticate_user!
  before_action :set_wunature, only: [:show, :edit, :update, :destroy]

  # GET /wunatures
  def index
    @wunatures = Wunature.all
  end

  # GET /wunatures/1
  def show
      redirect_to users_dashboard_path, notice: 'Wunature was successfully created.'
  end

  # GET /wunatures/new
  def new
    @wunature = Wunature.new
  end

  # GET /wunatures/1/edit
  def edit
  end

  # POST /wunatures
  def create
    @wunature = Wunature.new(wunature_params)
    if @wunature.save
      redirect_to @wunature, notice: 'Wunature was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /wunatures/1
  def update
    if @wunature.update(wunature_params)
      redirect_to @wunature, notice: 'Wunature was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /wunatures/1
  def destroy
    @wunature.destroy
    redirect_to wunatures_url, notice: 'Wunature was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wunature
      @wunature = Wunature.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wunature_params
      params.require(:wunature).permit(:description)
    end
end
