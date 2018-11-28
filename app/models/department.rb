class Department < ApplicationRecord
	has_many :agents
	has_many :entries
end
