ActiveAdmin.register Incentive do
	active_admin_import validate: false,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "you can configure CSV options",
                              csv_options: { col_sep: ";", row_sep: nil, quote_char: nil }
                          )
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_id, :uph, :quality, :improvement_opp, :occupancy, :turntime, :contracts, :aht, :date
# belongs_to :user
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	
end
