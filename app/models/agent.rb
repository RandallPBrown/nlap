class Agent < ApplicationRecord
	belongs_to :department
	has_many :entries
    accepts_nested_attributes_for :department
    accepts_nested_attributes_for :entries
	belongs_to :user
	def user_email
    	self.user.email
  	end  
end
