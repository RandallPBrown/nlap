class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :agents, :department, :dept
  end
end
