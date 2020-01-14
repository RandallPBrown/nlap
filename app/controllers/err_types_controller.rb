class ErrTypesController < ApplicationController
  layout "scaffold"
  before_action :authorize_admin, except: [:index, :show]
  before_action :authenticate_user!
  before_action :set_err_type, only: [:show, :edit, :update, :destroy]

  # GET /err_types
  def index
    @err_types = ErrType.all
  end

  # GET /err_types/1
  def show
  end

  # GET /err_types/new
  def new
    @err_type = ErrType.new
  end

  # GET /err_types/1/edit
  def edit
  end

  # POST /err_types
  def create
    @err_type = ErrType.new(err_type_params)

    if @err_type.save
      redirect_to @err_type, notice: 'Err type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /err_types/1
  def update
    if @err_type.update(err_type_params)
      redirect_to @err_type, notice: 'Err type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /err_types/1
  def destroy
    @err_type.destroy
    redirect_to err_types_url, notice: 'Err type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_err_type
      @err_type = ErrType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def err_type_params
      params.require(:err_type).permit(:description)
    end
end
