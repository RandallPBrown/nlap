class AddStartToProcedures < ActiveRecord::Migration[5.1]
  def change
    add_column :procedures, :start, :string
  end
end
