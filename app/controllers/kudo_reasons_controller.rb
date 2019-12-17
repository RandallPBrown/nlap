class KudoReasonsController < InheritedResources::Base
	layout "scaffold"
  	
  	private

    def kudo_reason_params
      params.require(:kudo_reason).permit(:description)
    end
end

