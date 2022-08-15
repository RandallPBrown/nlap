class AddServiceorderToTools < ActiveRecord::Migration[5.1]
  def change
    add_column :tools, :serviceorder, :string
  end
end
