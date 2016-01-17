##
# A join table, Image <-> Collection
# If the image is destroyed, this will also be destroyed, meaning that the
# image is automatically removed from the collection.
#
class CollectionImage < ActiveRecord::Base
  belongs_to :image
  belongs_to :collection, touch: true
  belongs_to :user
  validates :image_id, uniqueness: { scope: :collection_id }
end
