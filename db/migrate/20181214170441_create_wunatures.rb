class CreateWunatures < ActiveRecord::Migration[5.1]
  def change
    create_table :wunatures do |t|
      t.string :description

      t.timestamps
    end
  end
end
