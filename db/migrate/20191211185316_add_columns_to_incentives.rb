class AddColumnsToIncentives < ActiveRecord::Migration[5.1]
  def change
    add_column :incentives, :turntime, :float
    add_column :incentives, :error_amount, :float
    add_column :incentives, :contracts, :integer
  end
end
