class CreateMfgWarranties < ActiveRecord::Migration[5.1]
  def change
    create_table :mfg_warranties do |t|
      t.date :dop
      t.string :model_number
      t.text :warranty_link

      t.timestamps
    end
  end
end
