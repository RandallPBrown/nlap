class CreateErrTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :err_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
