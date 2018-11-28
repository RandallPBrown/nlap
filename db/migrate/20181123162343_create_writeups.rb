class CreateWriteups < ActiveRecord::Migration[5.1]
  def change
    create_table :writeups do |t|
      t.string :type
      t.date :wdate
      t.text :desc

      t.timestamps
    end
  end
end
