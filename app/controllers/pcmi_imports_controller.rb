class PcmiImportsController < ApplicationController
  layout "scaffold"

  before_action :set_pcmi_import, only: [:show, :edit, :update, :destroy]

  # GET /pcmi_imports
  def index
    @pcmi_imports = PcmiImport.all
  end

  # GET /pcmi_imports/1
  def show
  end

  # GET /pcmi_imports/new
  def new
    @pcmi_import = PcmiImport.new
  end

  # GET /pcmi_imports/1/edit
  def edit
  end

  # POST /pcmi_imports
  def create
    @pcmi_import = PcmiImport.new(pcmi_import_params)

    if @pcmi_import.save
      redirect_to @pcmi_import, notice: 'Pcmi import was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pcmi_imports/1
  def update
    if @pcmi_import.update(pcmi_import_params)
      redirect_to @pcmi_import, notice: 'Pcmi import was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pcmi_imports/1
  def destroy
    @pcmi_import.destroy
    redirect_to pcmi_imports_url, notice: 'Pcmi import was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcmi_import
      @pcmi_import = PcmiImport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pcmi_import_params
      params.require(:pcmi_import).permit(:status, :priority, :servicer, :claim, :invoice, :first_name, :last_name, :report_date, :repair_date, :email)
    end
end
