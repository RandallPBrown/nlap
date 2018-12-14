class Dap < ApplicationRecord
  belongs_to :user
  belongs_to :writeup
  belongs_to :wunature
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :writeup
  accepts_nested_attributes_for :wunature
  scope :written,  -> {
    where("daps.ddate > ?", Time.now-90.days)
  }
end
