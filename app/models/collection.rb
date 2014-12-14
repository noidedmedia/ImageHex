class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :collection_images
  has_many :images, through: :collection_images
end
