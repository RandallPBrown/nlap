class AddResourceIdToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :resource_id, :integer
  end
end
