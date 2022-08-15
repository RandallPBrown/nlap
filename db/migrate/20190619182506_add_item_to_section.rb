class AddItemToSection < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :item, :string
  end
end
