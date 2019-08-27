class CreateFergusons < ActiveRecord::Migration[5.1]
  def change
    create_table :fergusons do |t|
      t.references :user, foreign_key: true
      t.references :district, foreign_key: true
      t.string :so_number
      t.string :customer_name
      t.string :sp_name
      t.string :address
      t.string :manufacturer
      t.string :product
      t.string :model
      t.boolean :escalated
      t.boolean :leaking
      t.boolean :customer_fo
      t.boolean :servicer_fo
      t.boolean :dealer_fo

      t.timestamps
    end
  end
end
