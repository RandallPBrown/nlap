class AddReadAtToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :read_at, :time
  end
end
