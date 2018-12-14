class AddWunatureToDaps < ActiveRecord::Migration[5.1]
  def change
    add_reference :daps, :wunature, foreign_key: true
  end
end
