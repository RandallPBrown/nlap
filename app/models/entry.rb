class Entry < ApplicationRecord
  belongs_to :agent
  belongs_to :occurrence
end
