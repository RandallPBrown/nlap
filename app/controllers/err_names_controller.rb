class ErrNamesController < ApplicationController
  layout "scaffold"

  before_action :set_err_name, only: [:show, :edit, :update, :destroy]

  # GET /err_names
  def index
    @err_names = ErrName.all
  end

  # GET /err_names/1
  def show
  end

  # GET /err_names/new
  def new
    @err_name = ErrName.new
  end

  # GET /err_names/1/edit
  def edit
  end

  # POST /err_names
  def create
    @err_name = ErrName.new(err_name_params)

    if @err_name.save
      redirect_to @err_name, notice: 'Err name was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /err_names/1
  def update
    if @err_name.update(err_name_params)
      redirect_to @err_name, notice: 'Err name was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /err_names/1
  def destroy
    @err_name.destroy
    redirect_to err_names_url, notice: 'Err name was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_err_name
      @err_name = ErrName.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def err_name_params
      params.require(:err_name).permit(:errname)
    end
end
