class CreateMfgParts < ActiveRecord::Migration[5.1]
  def change
    create_table :mfg_parts do |t|
      t.string :part_name
      t.string :part_number
      t.references :manufacturer, foreign_key: true

      t.timestamps
    end
  end
end
