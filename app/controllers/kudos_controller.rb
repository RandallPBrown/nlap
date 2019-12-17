class KudosController < InheritedResources::Base
	layout "scaffold"
  	

  	
  	private
    
    def kudo_params
      params.require(:kudo).permit(:user_id, :date, :kudo_reason_id, :kudo_status_id, :description, :submitted_by)
    end
end

