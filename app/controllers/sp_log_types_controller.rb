class SpLogTypesController < ApplicationController
  layout "scaffold"

  before_action :set_sp_log_type, only: [:show, :edit, :update, :destroy]

  # GET /sp_log_types
  def index
    @sp_log_types = SpLogType.all
  end

  # GET /sp_log_types/1
  def show
  end

  # GET /sp_log_types/new
  def new
    @sp_log_type = SpLogType.new
  end

  # GET /sp_log_types/1/edit
  def edit
  end

  # POST /sp_log_types
  def create
    @sp_log_type = SpLogType.new(sp_log_type_params)

    if @sp_log_type.save
      redirect_to @sp_log_type, notice: 'Sp log type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sp_log_types/1
  def update
    if @sp_log_type.update(sp_log_type_params)
      redirect_to @sp_log_type, notice: 'Sp log type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sp_log_types/1
  def destroy
    @sp_log_type.destroy
    redirect_to sp_log_types_url, notice: 'Sp log type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sp_log_type
      @sp_log_type = SpLogType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sp_log_type_params
      params.require(:sp_log_type).permit(:highlight)
    end
end
