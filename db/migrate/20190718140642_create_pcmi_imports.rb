class CreatePcmiImports < ActiveRecord::Migration[5.1]
  def change
    create_table :pcmi_imports do |t|
      t.string :status
      t.string :priority
      t.string :servicer
      t.string :claim
      t.string :invoice
      t.string :first_name
      t.string :last_name
      t.string :report_date
      t.string :repair_date
      t.string :email

      t.timestamps
    end
  end
end
