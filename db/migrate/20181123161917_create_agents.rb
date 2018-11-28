class CreateAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :agents do |t|
      t.string :fname
      t.string :lname
      t.date :hire

      t.timestamps
    end
  end
end
