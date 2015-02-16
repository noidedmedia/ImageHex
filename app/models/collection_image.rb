class CollectionImage < ActiveRecord::Base
  belongs_to :image
  belongs_to :collection
end
