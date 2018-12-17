class AddDeptToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :dept, :string
  end
end
