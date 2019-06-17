class ProceduresController < ApplicationController
  layout "scaffold"

  before_action :set_procedure, only: [:show, :edit, :update, :destroy]

  # GET /procedures
  def index
    @procedures = Procedure.all
  end

  # GET /procedures/1
  def show
  end

  # GET /procedures/new
  def new
    @procedure = Procedure.new
  end

  # GET /procedures/1/edit
  def edit
  end

  # POST /procedures
  def create
    @procedure = Procedure.new(procedure_params)

    if @procedure.save
      render :new, notice: 'Procedure was successfully created.'
    else
      redirect_to :new
    end
  end

  # PATCH/PUT /procedures/1
  def update
    if @procedure.update(procedure_params)
      redirect_to @procedure, notice: 'Procedure was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /procedures/1
  def destroy
    @procedure.destroy
    redirect_to procedures_url, notice: 'Procedure was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def procedure_params
      params.require(:procedure).permit(:section, :goal, :description, :start)
    end
end
