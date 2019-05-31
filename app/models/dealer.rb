class Dealer < ApplicationRecord
  belongs_to :buying_group
  has_many :contacts
  has_many :tools
end
