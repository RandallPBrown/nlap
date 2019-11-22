class AddErrTypeToErrLog < ActiveRecord::Migration[5.1]
  def change
    add_reference :err_logs, :err_type, foreign_key: true
  end
end
