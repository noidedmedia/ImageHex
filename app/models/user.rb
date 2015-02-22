##
# A user is exactly what it says on the tin: somebody who uses imagehex under a name.
# There are (curently) two types of users: an admin and a normal user.
# This distinction is stored as an enum.
# Admins have power over the entire site and can do basically anything.
# In order to prevent mishaps, you need direct database access to make a
# user an admin.
class User < ActiveRecord::Base
  # Use a friendly id to find by name
  extend FriendlyId
  friendly_id :name, use: :slugged
  ################
  # ASSOCIATIONS #
  ################
  ##
  # Join table: users -> collections

  has_many :subscriptions
  has_many :subscribed_collections,
    through: :subscriptions,
    source: :collection

  has_many :images
  has_many :curatorships
  has_many :collections, through: :curatorships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable

  ###############
  # VALIDATIONS #
  ###############
  validates :name, presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: /\w+/}
  validates :page_pref, inclusion: {:in => (1..100)}

  #############
  # CALLBACKS #
  #############
  after_create :make_collections


  ####################
  # INSTANCE METHODS #
  ####################

  ##
  # Get all images in all collections this user is subscribed to.
  def image_feed
    Image.where(id: subscribed_collections.joins(:collection_images).pluck(:image_id))
  end

  def subscribe! c
    c.subscribers << self
  end
  ##
  # Convenience method to access the favorites collection for a user
  def favorites
    collections.favorites.first
  end
  ##
  # Add an image to a user's favorites
  def favorite! i
    favorites.images << i
  end


  ##
  # Add an image to a user's creations
  def created! i
    creations.images << i
  end

  ##
  # Convenience method ot access the creations collection for a user
  def creations
    collections.creations.first
  end
  protected

  ##
  # All users have to have a Favorite collection and a Created collection.
  # This method makes both of those collections in a callback on user creation.
  def make_collections
    Favorite.create!(users: [self])
    Creation.create!(users: [self])
  end

  enum role: [:normal, :admin]
end
