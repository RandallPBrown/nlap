class WriteupsController < ApplicationController
  layout "scaffold"

  before_action :set_writeup, only: [:show, :edit, :update, :destroy]

  # GET /writeups
  def index
    @writeups = Writeup.all
  end

  # GET /writeups/1
  def show
  end

  # GET /writeups/new
  def new
    @writeup = Writeup.new
  end

  # GET /writeups/1/edit
  def edit
  end

  # POST /writeups
  def create
    @writeup = Writeup.new(writeup_params)

    if @writeup.save
      redirect_to @writeup, notice: 'Writeup was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /writeups/1
  def update
    if @writeup.update(writeup_params)
      redirect_to @writeup, notice: 'Writeup was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /writeups/1
  def destroy
    @writeup.destroy
    redirect_to writeups_url, notice: 'Writeup was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writeup
      @writeup = Writeup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def writeup_params
      params.require(:writeup).permit(:type, :wdate, :desc)
    end
end
