class MfgWarranty < ApplicationRecord
	include PgSearch
	pg_search_scope :search, :against => :model_number

end
