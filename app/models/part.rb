class Part < ApplicationRecord
  include PgSearch
  belongs_to :product
  belongs_to :buying_group

  pg_search_scope :search,
                  :against => [:part_number]
   
   def self.perform_search(keyword)
      if keyword.present?
      then Part.search(keyword).order(part_number: :desc)
      else Part.all
      end
    end
end
