class AddUsernameToTools < ActiveRecord::Migration[5.1]
  def change
    add_column :tools, :username, :string
  end
end
