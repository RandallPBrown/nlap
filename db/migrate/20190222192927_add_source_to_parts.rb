class AddSourceToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :source, :string
  end
end
