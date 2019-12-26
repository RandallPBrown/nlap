class RecipientGroupsController < ApplicationController
	layout "scaffold"

  before_action :set_recipient_group, only: [:show, :edit, :update, :destroy]
  
  # GET /recipients
  def index
    @recipient_groups = RecipientGroup.all
  end

  # GET /recipients/1
  def show
  end

  # GET /recipients/new
  def new
    @recipient_group = RecipientGroup.new
  end

  # GET /recipients/1/edit
  def edit
  end

  # POST /recipients
  def create
    @recipient_group = RecipientGroup.new(recipient_group_params)

    if @recipient_group.save
      redirect_to @recipient_group, notice: 'Recipient_group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /recipients/1
  def update
    if @recipient_group.update(recipient_group_params)
      redirect_to @recipient_group, notice: 'Recipient_group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /recipients/1
  def destroy
    @recipient_group.destroy
    redirect_to recipients_group_url, notice: 'Recipient_group was successfully destroyed.'
  end

  private
    def set_recipient_group
      @recipient_group = RecipientGroup.find(params[:id])
    end

    def recipient_group_params
      params.require(:recipient_group).permit(:description)
    end
end

