class Dap < ApplicationRecord
  resourcify
  attr_accessor :occurrence_since_dap, :total_occurrences_since_writeup, :total_active_writeup, :written_end
	include PgSearch
  	belongs_to :user
  	belongs_to :writeup
  	belongs_to :wunature
    has_many :agents
  	has_one :department, :through => :user
  	accepts_nested_attributes_for :user
    accepts_nested_attributes_for :agents
  	accepts_nested_attributes_for :writeup
  	accepts_nested_attributes_for :wunature
  	scope :written,  -> {
    	where(ddate: 60.days.ago...Date.tomorrow.beginning_of_day)
  	}

    scope :occurrence_user, -> {
          joins(:occurrence, agent: :user)
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


  def total_active_writeup
    Dap.user_writeups(self.user_id)
  end

  def self.user_writeups(user_id)
    
    Dap.where('ddate > ?', Time.now.end_of_day-60.days).joins(:user).group(:user_id).where("users.id = ?", user_id).pluck(:user_id).count
  end

  def occurrence_since_dap
    Dap.days_since_last_writeup(self.user_id)
  end

  def self.days_since_last_writeup(user_id)
  ddate = Dap.written.joins(:writeup,:user)
      .where("users.id = ?", user_id)
      .group(:id)
      .order(ddate: :asc)
      .pluck(:ddate)
      puts ddate.inspect
    if ddate.present?
      Entry.occurrence_user.where(:edate => ddate.last.beginning_of_day..Time.zone.now.end_of_day).group(:user_id).where("users.id = ?", user_id).sum(:ovalue).values.join(' ')
    else
      return 0
    end  
  end

  def total_occurrences_since_writeup
    Dap.effective_total_occurrences(self.user_id)
  end

  def self.effective_total_occurrences(user_id)
  ddate = Dap.joins(:writeup,:user)
      .where("users.id = ?", user_id)
      .group(:id)
      .order(ddate: :asc)
      .pluck(:ddate)
      puts ddate.inspect
    if ddate.present?
      Entry.effective.occurrence_user.where(edate: ddate.last.beginning_of_day..Time.zone.now.end_of_day).group(:user_id).where("users.id = ?", user_id).sum(:ovalue).values.join(' ')
    else
      return 0
    end  
  end
end
