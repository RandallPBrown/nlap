class CreateIncentiveSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :incentive_settings do |t|
      t.float :occupancy
      t.float :uph
      t.float :attendance
      t.float :quality
      t.integer :error
      t.float :error_amount
      t.float :turntime
      t.float :contracts
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
