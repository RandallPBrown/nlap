ActiveAdmin.register Entry do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	# belongs_to :agent
	permit_params :agent_id, :dept, :occurrence_id, :edate, :edesc, occurrence: [:ovalue]
	form do |f|
	    f.inputs 'Agent' do
	      f.grouped_collection_select :agent_id, Department.order(:id), :agents, :name, :id, :user_full_name, {}, {:class=>'form-control'}
	    end
	    f.inputs 'Occurrence' do
	    	f.collection_select :occurrence_id, Occurrence.order(:id), :id, :name, {}, {:class=>'form-control form-control-sm text-dark'}
	    end
	    f.inputs 'Date' do
	      f.date_field :edate, class: 'form-control form-control-sm text-dark'
	    end
	    f.inputs 'Error Description' do
	      f.text_area :edesc, class: 'form-control form-control-sm text-dark'
	  end
	end
  # belongs_to :user, :through => :agent
  # belongs_to :occurrence
  # has_one :user, :through => :agent
  # has_one :department, :through => :agent
  # accepts_nested_attributes_for :agent
  # accepts_nested_attributes_for :occurrence
  # accepts_nested_attributes_for :user
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
