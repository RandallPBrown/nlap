class CreateJoinTableRolesUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :roles, :users do |t|
      t.references :role, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
