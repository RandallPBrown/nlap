class Department < ApplicationRecord
	resourcify
	has_many :agents
	has_many :users
	has_many :entries
end
