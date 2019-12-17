class KudoStatusesController < InheritedResources::Base
	layout "scaffold"
  	
  	private

    def kudo_status_params
      params.require(:kudo_status).permit(:description)
    end
end

