class CreateErrStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :err_statuses do |t|
      t.string :statusname
      t.integer :errvalue

      t.timestamps
    end
  end
end
