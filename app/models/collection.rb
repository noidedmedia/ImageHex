##
# Collection is a way to organize images outside of the content within.
# An example of this might be all images that happened at a particular place
# in time, all images which have subjective quality in the opinion of a user
# (something like "beautiful"), or all the pages of a comic.
#
# It is an abstract class that uses STI to implement different functionality
# on child classes.
class Collection < ActiveRecord::Base
  ################
  # ASSOCIATIONS #
  ################

  # join table: User -> Collection
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
  # Join table: User -> Collection
  has_many :curatorships
  has_many :curators, through: :curatorships, source: :user
  # Join table: Collection -> Images
  has_many :collection_images
  # Collections are useless without images.
  # Collections also do not need duplicates, thus the uniq specifier
  has_many :images, ->{uniq}, through: :collection_images
  ###############
  # VALIDATIONS #
  ###############
  validates :name, presence: true

  ##########
  # SCOPES #
  ##########

  scope :favorites, ->{ where(type: "Favorite") }
  scope :creations, ->{ where(type: "Creation") }
  scope :subjective, -> { where(type: "Subjective") }
  #####################
  # INSTANCE  METHODS #
  #####################

  ##
  # Does a user curate this collection?
  # +u+:: the user
  def curated?(u)
    self.curators.include?(u)
  end
end
