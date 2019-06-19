class Procedure < ApplicationRecord
	has_many :tools
	has_many :sections
end
