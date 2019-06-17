class CreateProcedures < ActiveRecord::Migration[5.1]
  def change
    create_table :procedures do |t|
      t.string :section
      t.string :goal
      t.text :description

      t.timestamps
    end
  end
end
