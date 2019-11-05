class Incentive < ApplicationRecord
  belongs_to :user
  require 'smarter_csv'

	def self.import(file)
		SmarterCSV.process(file.path, col_sep: ',') do |row|  
	   		Incentive.create! row 
		end  
	end
end
