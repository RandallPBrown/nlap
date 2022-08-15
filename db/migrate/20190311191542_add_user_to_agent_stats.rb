class AddUserToAgentStats < ActiveRecord::Migration[5.1]
  def change
    add_reference :agent_stats, :user, foreign_key: true
  end
end
