##
# Collection is a way to organize images outside of the content within.
class Collection < ActiveRecord::Base
  ################
  # ASSOCIATIONS #
  ################
  
  # Curator for this collection
  belongs_to :user
  # Join table: Collection -> Images
  has_many :collection_images
  # Collections are useless without images.
  # Collections also do not need duplicates, thus the uniq specifier
  has_many :images, ->{uniq}, through: :collection_images

  ###############
  # VALIDATIONS #
  ###############
  validates :user, presence: true
  validates :name, presence: true
end
