class ChangeDepartmentsType < ActiveRecord::Migration[5.1]
  def change
  	remove_column :agents, :departments_id, :bigint
  	add_reference :agents, :department, foreign_key: true
  end
end
