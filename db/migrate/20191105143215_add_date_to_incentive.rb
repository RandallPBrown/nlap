class AddDateToIncentive < ActiveRecord::Migration[5.1]
  def change
    add_column :incentives, :date, :date
  end
end
