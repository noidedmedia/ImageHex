##
# A user is exactly what it says on the tin: somebody who uses imagehex under a name.
# There are (curently) two types of users: an admin and a normal user.
# This distinction is stored as an enum.
# Admins have power over the entire site and can do basically anything.
# In order to prevent mishaps, you need direct database access to make a
# user an admin.
#
# == Relations
# collections:: collections the user curates. See Collection for more
#               information. All  users are created with a Favorites 
#               collection and a Creations collection, which are special.
# subscriptions:: represents all the collections a user is
#                 subscribed to. Using user.image_feed will 
#                 give a list of all images in
#                 all collections the user is subscribed to.
# notifications:: Anything the user needs to know. Using user.notifications
#                 .unread gives all
#                 unread notifications.
#
class User < ActiveRecord::Base
  # Use a friendly id to find by name
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum role: [:normal, :admin]


  has_attached_file :avatar,
    styles: {
    original: "500x500>#",
    medium: "300x300>#",
    small: "200x200>#",
    tiny: "100x100>#"
  },
    path: ($AVATAR_PATH ? $AVATAR_PATH : "avatars/:id_:style.:extension"),
    default_url: "default-avatar.svg"


  validates_attachment_content_type :avatar, 
    content_type: /\Aimage\/.*\Z/

    validates_with AttachmentSizeValidator, 
    attributes: :avatar,
    less_than: 2.megabytes

  ##
  # Join table: users -> collections
  has_many :subscriptions
  has_many :comments
  has_many :subscribed_collections,
    through: :subscriptions,
    source: :collection
  has_many :image_reports
  has_many :notifications
  has_many :images
  has_many :curatorships
  has_many :collections, through: :curatorships
  has_many :user_creations
  has_many :creations, -> { order(created_at: :desc)},  through: :user_creations

  # ArtistSubscriber is a join table of User to User.
  # This is, as you imagine, kind of annoying to deal with.
  # So we split it up into two relationships
  # This is the first. It's the artists this user is subscribed to.
  has_many :artist_subscriptions, foreign_key: :user_id
  # and here we have the actual users
  has_many :subscribed_artists, 
    through: :artist_subscriptions,
    source: :artist

  # now we have the artists subscribers.
  # this has many is for when the user is in the role of artist
  has_many :artist_subscribers,
    class_name: :ArtistSubscription,
    foreign_key: :artist_id

  # and here's a list of the users that are subscribed to us
  has_many :subscribers,
    through: :artist_subscribers,
    source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable

  ###############
  # VALIDATIONS #
  ###############
  validates :name, presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: /\A([[:alpha:]]|\w)+\z/ },
    length: {in: 2..25}
  validates :page_pref, inclusion: {:in => (1..100)}
  validate :elsewhere_is_not_evil
  #############
  # CALLBACKS #
  #############
  after_create :make_collections

  before_save :coerce_content_pref!


  #################
  # CLASS METHODS #
  #################

  def self.popular_creators(interval = 14.days.ago..Time.now)
    joins(creations: :collection_images)
    .group("users.id")
    .where(collection_images: {created_at: interval})
    .order("COUNT(collection_images) DESC")
  end

  def self.recent_creators
    joins(:creations)
      .group("users.id")
      .order("MAX(user_creations.created_at) DESC")
  end
  ####################
  # INSTANCE METHODS #
  ####################

  ##
  # See if the user is subscribed to a collection
  # Returns true or false
  # c:: the collection we are checking
  def subscribed_to? c
    c.subscribers.include? self
  end
  ##
  # Quickly get a user avatar, pre-resized
  def avatar_img
    avatar.url(:medium)
  end

  ##
  # Get a user's avatar thumbnail, pre-resized
  def avatar_img_thumb
    avatar.url(:tiny)
  end

  ##
  # Get all images in all collections this user is subscribed to.
  def image_feed
    Image.feed_for(self)
  end
  ##
  # Add a collection to the user's subscriptions.
  # c:: the collection to add.
  def subscribe! c
    c.subscribers << self
  end

  def unsubscribe! c
    c.subscribers.destroy(self)
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
  # Returns true or false depending on if the user has favorited the image.
  def favorited?(image)
    favorites.images.include? image
  end

  ##
  # Add an image to a user's creationed collection.
  def created! i
    creations << i 
  end

  ##
  # Get a user's curatorship on a collection, if it exists
  #
  # c:: the collection
  def curatorship_for(c)
    Curatorship.where(user: self, collection: c).first
  end
  protected

  ##
  # Rails passes the true and false values from checkboxes as "0" and "1"
  # we here convert them into the proper "True" and "false"
  def coerce_content_pref!
    return unless content_pref
    self.content_pref = self.content_pref.map do |k, v|
      if k.start_with?("nsfw")
        if v.is_a? String
          [k, v == "0" ? false : true]
        else
          [k, v]
        end
      end
    end.to_h
  end


  ##
  # All users have to have a Favorite collection and a Created collection.
  # This method makes both of those collections in a callback on user creation.
  def make_collections
    Favorite.create!(curators: [self])
  end

  def elsewhere_is_not_evil
    if elsewhere == nil
      return
    end
    if !self.elsewhere.is_a? Array
      errors.add(:elsewhere, "is malformed, suggesting weird scripting")
    else
      self.elsewhere.each do |e|
        unless e.is_a? String
          errors.add(:elsewhere, "contains non-string values")
          next
        end
        begin
          URI.parse(e)
        rescue URI::InvalidURIError => e
          errors.add(:elsewhere, "Contains an invalid URL")
        end
      end
    end
  end
  ##
  # Class method to get a user from onmiauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end
