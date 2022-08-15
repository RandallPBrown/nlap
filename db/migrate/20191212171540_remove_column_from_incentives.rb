class RemoveColumnFromIncentives < ActiveRecord::Migration[5.1]
  def change
    remove_column :incentives, :error_amount, :float
  end
end
