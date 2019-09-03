class Agent < ApplicationRecord
  resourcify
    include PgSearch
  belongs_to :department
  belongs_to :user
  has_many :daps
	has_many :entries
  has_many :occurrences, :through => :entries
    accepts_nested_attributes_for :department
    accepts_nested_attributes_for :daps
    accepts_nested_attributes_for :entries
    accepts_nested_attributes_for :occurrences
    accepts_nested_attributes_for :user

 scope :effective,  -> {
    where("entries.edate > ?", Time.now-90.days)
  }
	scope :occurrence_user, -> {
    	joins(:occurrence, agent: :user)
  	}

  scope :index_controller, -> {
    includes(:user, :department, entries: :user, user: :daps).joins(:user).order('users.first_name asc')
  }

	def user_full_name
    	self.user.full_name
  end  

    pg_search_scope :search,
                    :associated_against => {
       :user => [:first_name, :last_name], :department => [:name]
      }
    def self.perform_search(keyword)
      if keyword.present?
      then Agent.joins(:user).search(keyword)
      else Agent.joins(:user).all
      end
    end


end
