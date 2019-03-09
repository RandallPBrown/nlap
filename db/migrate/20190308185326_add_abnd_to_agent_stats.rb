class AddAbndToAgentStats < ActiveRecord::Migration[5.1]
  def change
    add_column :agent_stats, :abnd, :integer
  end
end
