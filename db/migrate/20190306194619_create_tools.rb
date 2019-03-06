class CreateTools < ActiveRecord::Migration[5.1]
  def change
    create_table :tools do |t|
      t.text :receipt

      t.timestamps
    end
  end
end
