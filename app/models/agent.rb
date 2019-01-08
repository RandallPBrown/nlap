class Agent < ApplicationRecord
  belongs_to :department
  belongs_to :user
  has_many :daps
	has_many :entries
  has_many :occurrences, :through => :entries
    accepts_nested_attributes_for :department
    accepts_nested_attributes_for :daps
    accepts_nested_attributes_for :entries
    accepts_nested_attributes_for :occurrences

 scope :effective,  -> {
    where("entries.edate > ?", Time.now-180.days)
  }
	scope :occurrence_user, -> {
    	joins(:occurrence, agent: :user)
  	}

	def user_full_name
    	self.user.full_name
  end  
end
