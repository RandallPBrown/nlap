class KudosController < ApplicationController
	layout "scaffold"
  	  before_action :set_kudo, only: [:show, :edit, :update, :destroy]
  	  before_action :authorize_admin

  	def index
  		@kudos = Kudo.all
  	end

	  # GET /kudos/1
	  def show
	  end

	  # GET /kudos/new
	  def new
	    @kudo = Kudo.new
	  end

	  # GET /kudos/1/edit
	  def edit
	  end

	  # POST /kudos
	  def create
	    @kudo = Kudo.new(kudo_params)

	    if @kudo.save
	      redirect_to @kudo, notice: 'Kudo was successfully created.'
	    else
	      render :new
	    end
	  end

	  # PATCH/PUT /kudos/1
	  def update
	    if @kudo.update(kudo_params)
	      redirect_to @kudo, notice: 'Kudo was successfully updated.'
	    else
	      render :edit
	    end
	  end

	  # DELETE /kudos/1
	  def destroy
	    @kudo.destroy
	    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
	  end
  	
  	private
    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:user_id, :date, :kudo_reason_id, :kudo_status_id, :description, :submitted_by)
    end
end

