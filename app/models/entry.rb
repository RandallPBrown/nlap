class Entry < ApplicationRecord
  belongs_to :agent
  belongs_to :occurrence
  accepts_nested_attributes_for :occurrence
  scope :effective,  -> {
  	where("entries.created_at > ?", Time.now-90.days)
  }
  scope :today, -> {
  	where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }

end
