class Agent < ApplicationRecord
	belongs_to :department
	has_many :entries
    accepts_nested_attributes_for :department
end

