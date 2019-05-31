class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :priority
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :dealer, foreign_key: true

      t.timestamps
    end
  end
end
