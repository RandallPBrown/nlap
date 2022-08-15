class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts do |t|
      t.string :part_number
      t.string :part_name
      t.text :part_description
      t.references :product, foreign_key: true
      t.references :buying_group, foreign_key: true
      t.date :dop
      t.string :covered

      t.timestamps
    end
  end
end
