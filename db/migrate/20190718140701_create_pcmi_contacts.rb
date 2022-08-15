class CreatePcmiContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :pcmi_contacts do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
