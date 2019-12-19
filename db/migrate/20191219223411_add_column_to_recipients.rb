class AddColumnToRecipients < ActiveRecord::Migration[5.1]
  def change
    add_reference :recipients, :recipient_group, foreign_key: true
  end
end
