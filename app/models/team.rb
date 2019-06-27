class Team < ApplicationRecord
	has_many :departments
	belongs_to :group
end
