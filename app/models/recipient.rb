class Recipient < ApplicationRecord
  belongs_to :user
  belongs_to :recipient_group
end
