class AddAhtToIncentives < ActiveRecord::Migration[5.1]
  def change
    add_column :incentives, :aht, :float
  end
end
