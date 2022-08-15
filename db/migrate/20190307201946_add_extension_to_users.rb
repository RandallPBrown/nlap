class AddExtensionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :extension, :string
  end
end
