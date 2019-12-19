class Recipient < ApplicationRecord
  belongs_to :user
  has_one :recipient_group
end
