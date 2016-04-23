class ListingImage < ActiveRecord::Base
  belongs_to :image
  belongs_to :listing
end
