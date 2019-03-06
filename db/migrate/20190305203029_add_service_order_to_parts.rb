class AddServiceOrderToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :serviceorder, :string
  end
end
