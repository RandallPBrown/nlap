class AddColumnToOccurrences < ActiveRecord::Migration[5.1]
  def change
  	add_column :occurrences, :name, :string
  end
end
