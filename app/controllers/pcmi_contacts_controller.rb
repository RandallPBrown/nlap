class PcmiContactsController < ApplicationController
  layout "scaffold"

  before_action :set_pcmi_contact, only: [:show, :edit, :update, :destroy]

  # GET /pcmi_contacts
  def index
    @pcmi_contacts = PcmiContact.all
  end

  # GET /pcmi_contacts/1
  def show
  end

  # GET /pcmi_contacts/new
  def new
    @pcmi_contact = PcmiContact.new
  end

  # GET /pcmi_contacts/1/edit
  def edit
  end

  # POST /pcmi_contacts
  def create
    @pcmi_contact = PcmiContact.new(pcmi_contact_params)

    if @pcmi_contact.save
      redirect_to @pcmi_contact, notice: 'Pcmi contact was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pcmi_contacts/1
  def update
    if @pcmi_contact.update(pcmi_contact_params)
      redirect_to @pcmi_contact, notice: 'Pcmi contact was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pcmi_contacts/1
  def destroy
    @pcmi_contact.destroy
    redirect_to pcmi_contacts_url, notice: 'Pcmi contact was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcmi_contact
      @pcmi_contact = PcmiContact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pcmi_contact_params
      params.require(:pcmi_contact).permit(:name, :email)
    end
end
