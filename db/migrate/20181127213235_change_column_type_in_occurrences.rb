class ChangeColumnTypeInOccurrences < ActiveRecord::Migration[5.1]
  def change
  	rename_column :occurrences, :type, :ovalue
  end
end
