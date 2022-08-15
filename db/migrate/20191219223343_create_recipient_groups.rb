class CreateRecipientGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :recipient_groups do |t|
      t.string :description

      t.timestamps
    end
  end
end
