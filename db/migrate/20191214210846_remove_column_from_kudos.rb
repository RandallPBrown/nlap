class RemoveColumnFromKudos < ActiveRecord::Migration[5.1]
  def change
    remove_column :kudos, :status, :string
  end
end
