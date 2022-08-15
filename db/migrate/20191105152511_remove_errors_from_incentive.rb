class RemoveErrorsFromIncentive < ActiveRecord::Migration[5.1]
  def change
    remove_column :incentives, :errors, :string
  end
end
