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

  #########
  # ENUMS #
  #########

  # What type of collection this is
  enum kind: 
    # Created is a collection of images made by the user. Each user gets one.
    [:created, 
     # The users favorites. Each user also gets one.
     :favorites,
     # A chronological collection. This is either images in order of date
     # created, or in page order. So pages of a comic or something.
     :chrono,
     # subjective collections are basically the "other" kind of collection.
     :subjective]
  ###############
  # VALIDATIONS #
  ###############
  validates :user, presence: true
  validates :name, presence: true

  #################
  # CLASS METHODS #
  #################

  # We add this method alias because it's easier to think about the 
  # "curator" of a collection than it is to think about the user who own it
  # in some cases. Mostly for convenience
  alias_method :curator, :user
  alias_method :curator=, :user=
end
