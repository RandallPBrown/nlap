class RemoveColumnFromIncentiveSettings < ActiveRecord::Migration[5.1]
  def change
    remove_column :incentive_settings, :error_amount, :float
  end
end
