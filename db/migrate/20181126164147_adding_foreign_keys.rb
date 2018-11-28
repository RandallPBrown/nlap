class AddingForeignKeys < ActiveRecord::Migration[5.1]
  def change
  	add_reference :agents, :departments, index: true, foreign_key: true
  end
end
