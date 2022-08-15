class OccurrencesController < ApplicationController
  layout "scaffold"
  before_action :authorize_admin
  before_action :set_occurrence, only: [:show, :edit, :update, :destroy]

  # GET /occurrences
  def index
    @occurrences = Occurrence.all
  end

  # GET /occurrences/1
  def show
  end

  # GET /occurrences/new
  def new
    if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @occurrence = Occurrence.new
    else
      redirect_to occurrences_path, notice: 'Unauthorized, contact manager or above'
    end
  end

  # GET /occurrences/1/edit
  def edit
    if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
    
    else
      redirect_to occurrences_path, notice: 'Unauthorized, contact manager or above'
    end
  end

  # POST /occurrences
  def create
    @occurrence = Occurrence.new(occurrence_params)
    if @occurrence.save
      redirect_to @occurrence, notice: 'Occurrence was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /occurrences/1
  def update
    if @occurrence.update(occurrence_params)
      redirect_to @occurrence, notice: 'Occurrence was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /occurrences/1
  def destroy
    if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @occurrence.destroy
      redirect_to occurrences_url, notice: 'Occurrence was successfully destroyed.'
    else
      redirect_to occurrences_path, notice: 'Unauthorized, contact manager or above'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occurrence
      @occurrence = Occurrence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def occurrence_params
      params.require(:occurrence).permit(:name, :ovalue, :odate, :desc)
    end
end
