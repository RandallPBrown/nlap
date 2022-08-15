class ErrLog < ApplicationRecord
  belongs_to :user
  belongs_to :department
  belongs_to :err_name
  belongs_to :err_status
  has_one :err_type
  strip_attributes only: :err_type_id, replace_newlines: true, collapse_spaces: true
end
