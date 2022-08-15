class AddColumnsToErrLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :err_logs, :approved_by, :string
    add_column :err_logs, :err_notes, :text
    add_column :err_logs, :err_cost, :float
  end
end
