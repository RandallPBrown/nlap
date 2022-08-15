class RemoveColumnsFromDealer < ActiveRecord::Migration[5.1]
  def change
    remove_column :dealers, :name, :string
    remove_column :dealers, :address, :string
    remove_column :dealers, :phone, :string
  end
end
