class AddNoteToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :note, :text
  end
end
