class Occurrence < ApplicationRecord
	resourcify
	has_many :entries
end
