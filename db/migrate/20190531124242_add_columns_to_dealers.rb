class AddColumnsToDealers < ActiveRecord::Migration[5.1]
  def change
    add_column :dealers, :body_prefix, :text
    add_column :dealers, :body_suffix, :text
  end
end
