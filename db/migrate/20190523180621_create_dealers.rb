class CreateDealers < ActiveRecord::Migration[5.1]
  def change
    create_table :dealers do |t|
      t.string :name
      t.references :buying_group, foreign_key: true
      t.string :phone
      t.string :address
      t.boolean :appliance
      t.boolean :electronic
      t.boolean :furniture
      t.string :code

      t.timestamps
    end
  end
end
