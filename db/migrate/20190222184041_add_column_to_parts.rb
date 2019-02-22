class AddColumnToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :submitted_by, :string
    add_column :parts, :approved_by, :string
  end
end
