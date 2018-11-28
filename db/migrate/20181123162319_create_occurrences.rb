class CreateOccurrences < ActiveRecord::Migration[5.1]
  def change
    create_table :occurrences do |t|
      t.float :type
      t.date :odate
      t.text :desc

      t.timestamps
    end
  end
end
