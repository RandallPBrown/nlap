class ShortkeysController < ApplicationController
  layout "scaffold"

  before_action :set_shortkey, only: [:show, :edit, :update, :destroy]

  # GET /shortkeys
  def index
    @shortkeys = Shortkey.all

  end

  def data
    @shortkeys = Shortkey.all
    shortkey_array = Array.new
    @shortkeys.each do |shortkey| 
      shortkey_array << {'id': shortkey.id, 
       'department': shortkey.department.id, 
       'name': shortkey.name, 
       'body': shortkey.body
      }
    end 
    respond_to do |format|
      format.json {render :json => shortkey_array}
    end
  end

  # GET /shortkeys/1
  def show
    respond_to do |format|
      format.html
      format.json {render :json => @shortkey}
    end
  end

  # GET /shortkeys/new
  def new
    @shortkey = Shortkey.new
  end

  # GET /shortkeys/1/edit
  def edit
  end

  # POST /shortkeys
  def create
    @shortkey = Shortkey.new(shortkey_params)

    if @shortkey.save
      redirect_to @shortkey, notice: 'Shortkey was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /shortkeys/1
  def update
    if @shortkey.update(shortkey_params)
      redirect_to @shortkey, notice: 'Shortkey was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /shortkeys/1
  def destroy
    @shortkey.destroy
    redirect_to shortkeys_url, notice: 'Shortkey was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortkey
      @shortkey = Shortkey.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shortkey_params
      params.require(:shortkey).permit(:name, :body, :created_by, :department_id)
    end
end
