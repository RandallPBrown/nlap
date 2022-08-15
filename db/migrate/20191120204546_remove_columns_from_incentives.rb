class RemoveColumnsFromIncentives < ActiveRecord::Migration[5.1]
  def change
    remove_column :incentives, :quality, :string
    remove_column :incentives, :improvement_opp, :string
  end
end
