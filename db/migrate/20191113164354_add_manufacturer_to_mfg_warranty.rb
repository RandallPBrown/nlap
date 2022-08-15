class AddManufacturerToMfgWarranty < ActiveRecord::Migration[5.1]
  def change
    add_column :mfg_warranties, :manufacturer, :string
  end
end
