class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :department
	has_many :entries
  has_many :daps
  accepts_nested_attributes_for :department
  accepts_nested_attributes_for :entries
  accepts_nested_attributes_for :daps
  before_validation :allow_department
  has_one :agent, dependent: :destroy
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:agent) if self.roles.blank?
  end

  def allow_department
  		self.department_id
  end

  def full_name
    "#{first_name} #{last_name}"
  end  

  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end  
  
  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  
  
  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end  

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

  scope :written,  -> {
    where("daps.ddate > ?", Time.now-90.days)
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
end
