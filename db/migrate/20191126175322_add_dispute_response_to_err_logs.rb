class AddDisputeResponseToErrLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :err_logs, :dispute_response, :text
  end
end
