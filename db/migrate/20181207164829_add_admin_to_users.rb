class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :user, :admin, :boolean
  end
end
