class AddNameToProcedure < ActiveRecord::Migration[5.1]
  def change
    add_column :procedures, :name, :string
  end
end
