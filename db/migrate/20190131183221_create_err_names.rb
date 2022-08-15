class CreateErrNames < ActiveRecord::Migration[5.1]
  def change
    create_table :err_names do |t|
      t.string :errname

      t.timestamps
    end
  end
end
