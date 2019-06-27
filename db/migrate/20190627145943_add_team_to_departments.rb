class AddTeamToDepartments < ActiveRecord::Migration[5.1]
  def change
    add_reference :departments, :team, foreign_key: true
  end
end
