class AddDepartmentToAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :department, :string
  end
end
