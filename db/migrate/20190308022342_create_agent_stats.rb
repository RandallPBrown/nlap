class CreateAgentStats < ActiveRecord::Migration[5.1]
  def change
    create_table :agent_stats do |t|
      t.string :extension
      t.string :name
      t.date :date
      t.time :shift
      t.time :total_login
      t.time :total_break
      t.time :net_login
      t.time :requested_worktime
      t.float :availability
      t.float :occupancy
      t.integer :queue_calls
      t.time :queue_talk
      t.integer :direct_calls
      t.time :direct_talk
      t.integer :outbound_calls
      t.time :outbound_talk
      t.integer :callback_calls
      t.time :callback_talk
      t.integer :deleted
      t.integer :un_ans
      t.integer :picked
      t.integer :recover
      t.integer :power_dial
      t.time :acw
      t.time :wrapup_time
      t.integer :total_calls
      t.time :total_talk
      t.time :aht

      t.timestamps
    end
  end
end
