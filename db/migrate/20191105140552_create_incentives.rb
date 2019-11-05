class CreateIncentives < ActiveRecord::Migration[5.1]
  def change
    create_table :incentives do |t|
      t.references :user, foreign_key: true
      t.float :uph
      t.float :quality
      t.integer :errors
      t.float :occupancy

      t.timestamps
    end
  end
end
