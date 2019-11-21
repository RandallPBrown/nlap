class AddDisputeToErrLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :err_logs, :dispute, :text
  end
end
