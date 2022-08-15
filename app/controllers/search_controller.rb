class SearchController < ApplicationController
def index
   if params[:query].present?
     @mfg_warranties = MfgWarranty.search(params[:query])
   else
     @mfg_warranties = MfgWarranty.all
   end
 end
end
