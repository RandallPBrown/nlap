class AddColumnToKudos < ActiveRecord::Migration[5.1]
  def change
    add_reference :kudos, :kudo_status, foreign_key: true
  end
end
