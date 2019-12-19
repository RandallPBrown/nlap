class RecipientGroupsController < InheritedResources::Base
	layout "scaffold"

  before_action :set_recipient_group, only: [:show, :edit, :update, :destroy]
  private
    def set_recipient_group
      @recipient = Recipient.find(params[:id])
    end

    def recipient_group_params
      params.require(:recipient_group).permit(:description)
    end
end

