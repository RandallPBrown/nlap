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
end
