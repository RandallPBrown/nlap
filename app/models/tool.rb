class Tool < ApplicationRecord
	include PgSearch
	has_many :dealers
	has_many :contacts, :through => :dealers
	has_many :departments, :through => :dealers
	has_many :procedures
	has_many :sections, :through => :procedures
	accepts_nested_attributes_for :dealers
	accepts_nested_attributes_for :contacts
	accepts_nested_attributes_for :departments
	accepts_nested_attributes_for :procedures
	pg_search_scope :search,
		:associated_against => {
		:dealer => :code
	}
	pg_search_scope :search, :against => :model_number

end
