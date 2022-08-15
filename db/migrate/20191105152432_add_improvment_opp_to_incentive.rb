class AddImprovmentOppToIncentive < ActiveRecord::Migration[5.1]
  def change
    add_column :incentives, :improvement_opp, :integer
  end
end
