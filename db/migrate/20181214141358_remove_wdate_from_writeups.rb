class RemoveWdateFromWriteups < ActiveRecord::Migration[5.1]
  def change
    remove_column :writeups, :wdate, :date
  end
end
