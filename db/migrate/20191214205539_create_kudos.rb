class CreateKudos < ActiveRecord::Migration[5.1]
  def change
    create_table :kudos do |t|
      t.references :user, foreign_key: true
      t.date :date
      t.references :kudo_reason, foreign_key: true
      t.text :description
      t.string :submitted_by
      t.string :status

      t.timestamps
    end
  end
end
