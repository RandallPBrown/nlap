class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.references :procedure, foreign_key: true
      t.string :goal
      t.text :description
      t.string :start

      t.timestamps
    end
  end
end
