class AddColumnsToSpLog < ActiveRecord::Migration[5.1]
  def change
    add_column :sp_logs, :pcmi_dispatch, :boolean
    add_column :sp_logs, :website, :string
  end
end
