##
# Collection is a way to organize images outside of the content within.
class Collection < ActiveRecord::Base
  ################
  # ASSOCIATIONS #
  ################
  
  # join table: User -> Collection
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user 
  # Join table: User -> Collection
  has_many :curatorships
  has_many :users, through: :curatorships
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
  def curated?(u)
    self.users.include?(u)
  end
end
