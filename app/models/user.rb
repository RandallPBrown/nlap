class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :department
	has_many :entries
  accepts_nested_attributes_for :department
  accepts_nested_attributes_for :entries
  before_validation :allow_department
  has_one :agent
  def allow_department
  		self.department_id
  end
  def full_name
    "#{first_name} #{last_name}"
  end  
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
