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
	    @recipient = Recipient.all.includes(:recipient_groups).group(:id).where('recipient_groups.description = ?', 'Kudos').references(:recipient_groups)

	    if @kudo.save
	    	
	    	@recipient.includes(:recipient_group).each do |recipient|
		        KudoMailer.new_kudo_email(@kudo, recipient).deliver_now
		    end
	    	
	    	
	    	redirect_back(fallback_location: root_path)
      		flash[:notice] = 'Your submission will be reviewed by management. Thank you!'
	    else
	      render :new
	    end
	  end

	  # PATCH/PUT /kudos/1
	  def update
	    if @kudo.update(kudo_params)
	      redirect_back(fallback_location: root_path)
      		flash[:notice] = 'Kudos has been updated'
	    else
	      render :edit
	    end
	  end

	  # DELETE /kudos/1
	  def destroy
	    @kudo.destroy
	    redirect_back(fallback_location: root_path)
      	flash[:notice] = 'Destroyed Kudos'
	  end
  	
  	private
    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:user_id, :date, :kudo_reason_id, :kudo_status_id, :description, :submitted_by)
    end
end

