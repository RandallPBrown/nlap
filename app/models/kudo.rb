class Kudo < ApplicationRecord
  belongs_to :user
  belongs_to :kudo_reason
  belongs_to :kudo_status
end
