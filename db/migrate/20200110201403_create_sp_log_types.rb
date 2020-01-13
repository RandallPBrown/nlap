class CreateSpLogTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :sp_log_types do |t|
      t.text :highlight

      t.timestamps
    end
  end
end
