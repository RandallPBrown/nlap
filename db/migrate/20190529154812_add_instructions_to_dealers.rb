class AddInstructionsToDealers < ActiveRecord::Migration[5.1]
  def change
    add_column :dealers, :instructions, :text
  end
end
