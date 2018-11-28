class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :occurrence
      t.references :agent
      t.string :edesc
      t.date :edate
      t.timestamps
    end
  end
end
