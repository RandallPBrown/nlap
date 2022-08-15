class Team < ApplicationRecord
	has_many :departments
	has_one :group
end
