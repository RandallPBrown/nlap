class Occurrence < ApplicationRecord
	resourcify
	has_many :entries
	attr_accessor :total_occurrences

	def total_occurrences
		self.where("ovalue > ?", Time.now-60.days).sum(:ovalue)
	end
end
