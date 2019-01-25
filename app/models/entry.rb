class Entry < ApplicationRecord
  resourcify
  include PgSearch
  attr_accessor :total_effective_occurrence, :occurrences_today, :occurrence_ovalue_today, :occurrence_total
  belongs_to :agent
  belongs_to :occurrence
  has_one :user, :through => :agent
  has_one :department, :through => :agent
  accepts_nested_attributes_for :agent
  accepts_nested_attributes_for :occurrence
  accepts_nested_attributes_for :user


  scope :acd, -> {
    group("occurrences.name").order("occurrences.name DESC").count("occurrences.name").values
  }

  scope :acl, -> {
    group("occurrences.name").order("occurrences.name DESC").pluck("occurrences.name")
  }

  scope :ueae, -> {
    where("occurrences.ovalue > ?", 0.5).count(:name)
  }

  scope :uete2, -> {
    where("occurrences.name = ?", "Tardy").count(:name)
  }

  scope :uete, -> {
    sum(:ovalue)
  }

  scope :ue, -> {
    group(:id).order("entries.edate DESC")
  }

  scope :effective,  -> {
  	where("entries.edate > ?", Time.now-180.days)
  }
  scope :today, -> {
  	where(edate: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }
  scope :logged_user,  -> {
    where("entries.agent_id = ?", User.current_user)
  }
  
  scope :grouped_dept, -> {
    joins(:occurrence, agent: :department).group('departments.name')
  }

  scope :grouped_user, -> {
    joins(:occurrence, agent: [:user, :department]).group('users.email')
  }

  scope :occurrence_user, -> {
      joins(:occurrence, agent: :user)
  }

  scope :ovalue_sum, -> {
      group(:ovalue).sum(:ovalue)
  }

  pg_search_scope :search,
                  :associated_against => {
     :user => [:first_name, :last_name], :department => [:name], :occurrence => [:ovalue]
  }, :against => [:edesc, :edate]

  scope :date_desc, -> { 
    order( edate: :desc )
  }

  scope :date_asc, -> {
    order( edate: :asc )
  }

  def occurrence_total
    Entry.joins(:occurrence).sum(:ovalue)
  end

  def occurrence_ovalue_today
    Entry.today.joins(:occurrence).sum(:ovalue)
  end


  def occurrences_today
    Entry.today.joins(:agent).count(:id)
  end


  def total_effective_occurrence
    Entry.effective_occurrence(self.user.id)
  end

  def self.effective_occurrence(user_id)
    Entry.effective.occurrence_user
      .where("users.id = ?", user_id)
      .sum(:ovalue)
  end

  def start_time
    self.edate
  end

def self.to_csv
    CSV.generate do |csv|
      csv << column_names = %w{edate first_name last_name department_id name ovalue edesc   }
      all.each do |result|
        csv << result.attributes.merge(result.agent.user.attributes).merge(result.agent.department.attributes).merge(result.occurrence.attributes).values_at(*column_names)
      end
    end
  end

def self.perform_search(keyword)
    if keyword.present?
    then Entry.search(keyword).order(edate: :desc)
    else Entry.all
    end
  end
end
