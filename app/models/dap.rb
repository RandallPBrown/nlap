class Dap < ApplicationRecord
	include PgSearch
  	belongs_to :user
  	belongs_to :writeup
  	belongs_to :wunature
  	has_one :department, :through => :user
  	accepts_nested_attributes_for :user
  	accepts_nested_attributes_for :writeup
  	accepts_nested_attributes_for :wunature
  	scope :written,  -> {
    	where("daps.ddate > ?", Time.now-90.days)
  	}
  	pg_search_scope :search,
    	              :associated_against => {
    	 :user => [:first_name, :last_name], :department => [:name], :writeup => [:name]
    	}
  	def self.perform_search(keyword)
    if keyword.present?
    then Dap.search(keyword)
    else Dap.all
    end
  end
end
