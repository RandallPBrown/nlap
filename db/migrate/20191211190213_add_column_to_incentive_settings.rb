class AddColumnToIncentiveSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :incentive_settings, :aht, :float
  end
end
