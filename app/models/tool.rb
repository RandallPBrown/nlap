class Tool < ApplicationRecord
	include PgSearch
	has_many :dealers
	has_many :contacts, :through => :dealers
	has_many :departments, :through => :dealers
	accepts_nested_attributes_for :dealers
	accepts_nested_attributes_for :contacts
	accepts_nested_attributes_for :departments
	pg_search_scope :search,
		:associated_against => {
		:dealer => :code
	}
end
