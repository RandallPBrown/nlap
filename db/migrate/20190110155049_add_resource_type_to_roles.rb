class AddResourceTypeToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :resource_type, :string
  end
end
