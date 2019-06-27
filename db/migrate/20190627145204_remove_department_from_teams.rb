class RemoveDepartmentFromTeams < ActiveRecord::Migration[5.1]
  def change
    remove_reference :teams, :department, foreign_key: true
  end
end
