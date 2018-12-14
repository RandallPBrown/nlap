class RenameTypeToName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :writeups, :type, :name
  end
end
