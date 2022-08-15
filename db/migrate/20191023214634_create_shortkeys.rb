class CreateShortkeys < ActiveRecord::Migration[5.1]
  def change
    create_table :shortkeys do |t|
      t.string :name
      t.text :body
      t.string :created_by
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
