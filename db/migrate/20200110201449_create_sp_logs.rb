class CreateSpLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :sp_logs do |t|
      t.string :name
      t.string :phone
      t.string :state
      t.string :email
      t.text :notes
      t.references :sp_log_type, foreign_key: true

      t.timestamps
    end
  end
end
