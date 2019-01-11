class Agent < ApplicationRecord
  resourcify
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

  scope :uww, -> {
    joins(:writeup, :user).where("users.id = ?", current_user.id).count(:writeup_id)
  }

  scope :acd, -> {
    joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group("occurrences.name").order("occurrences.name DESC").count("occurrences.name").values
  }

  scope :acl, -> {
    joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group("occurrences.name").order("occurrences.name DESC").pluck("occurrences.name")
  }

  scope :ueae, -> {
    joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).where("occurrences.ovalue > ?", 0.5).count(:name)
  }

  scope :uete2, -> {
    joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).where("occurrences.name = ?", "Tardy").count(:name)
  }

  scope :uete, -> {
    joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).sum(:ovalue)
  }

  scope :ue, -> {
    joins(:occurrence, agent: :user).where("users.id = ?", current_user.id).group(:id).order("entries.edate DESC")
  }

	def user_full_name
    	self.user.full_name
  end  
end
