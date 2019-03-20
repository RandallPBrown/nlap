class AddServiceorderToErrLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :err_logs, :serviceorder, :string
  end
end
