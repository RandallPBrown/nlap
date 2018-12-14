class CreateDaps < ActiveRecord::Migration[5.1]
  def change
    create_table :daps do |t|
      t.string :description
      t.date :ddate
      t.references :user, foreign_key: true
      t.references :writeup, foreign_key: true

      t.timestamps
    end
  end
end
