class CreateKudoReasons < ActiveRecord::Migration[5.1]
  def change
    create_table :kudo_reasons do |t|
      t.text :description

      t.timestamps
    end
  end
end
