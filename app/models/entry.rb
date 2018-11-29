class Entry < ApplicationRecord
  belongs_to :agent
  belongs_to :occurrence
  accepts_nested_attributes_for :occurrence
end
