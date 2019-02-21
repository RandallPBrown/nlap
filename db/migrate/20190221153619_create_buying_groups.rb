class CreateBuyingGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :buying_groups do |t|
      t.string :bgname

      t.timestamps
    end
  end
end
