class CreateKudoStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :kudo_statuses do |t|
      t.string :description

      t.timestamps
    end
  end
end
