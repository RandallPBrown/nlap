class ErrLog < ApplicationRecord
  belongs_to :user
  belongs_to :department
  belongs_to :err_name
  belongs_to :err_status
end
