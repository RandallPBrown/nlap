class CreateErrLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :err_logs do |t|
      t.references :user, foreign_key: true
      t.references :department, foreign_key: true
      t.date :errdate
      t.references :err_name, foreign_key: true
      t.text :errdesc
      t.references :err_status, foreign_key: true
      t.string :errsubmitby

      t.timestamps
    end
  end
end
