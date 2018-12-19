class Entry < ApplicationRecord
  include PgSearch
  belongs_to :agent
  belongs_to :occurrence
  has_one :user, :through => :agent
  has_one :department, :through => :agent
  accepts_nested_attributes_for :agent
  accepts_nested_attributes_for :occurrence
  scope :effective,  -> {
  	where("entries.edate > ?", Time.now-180.days)
  }
  scope :today, -> {
  	where(edate: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }
  scope :logged_user,  -> {
    where("entries.agent_id = ?", User.current_user)
  }
    
  pg_search_scope :search,
                  :associated_against => {
     :user => [:first_name, :last_name], :department => [:name], :occurrence => [:ovalue]
  }, :against => [:edesc]


def self.perform_search(keyword)
    if keyword.present?
    then Entry.search(keyword)
    else Entry.all
    end
  end
end
