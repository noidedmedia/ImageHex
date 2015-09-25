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
  ################
  # ASSOCIATIONS #
  ################
  has_one :user_page, autosave: true
  # Accept nested attributes for the page
  accepts_nested_attributes_for :user_page, update_only: true

  ##
  # ID of the avatar is in avatar_id.
  belongs_to :avatar, class_name: "Image"
  ##
  # Join table: users -> collections
  has_many :subscriptions
  has_many :comments
  has_many :subscribed_collections,
    through: :subscriptions,
    source: :collection

  has_many :notifications
  has_many :images
  has_many :curatorships
  has_many :collections, through: :curatorships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :omniauthable, :omniauth_providers => [:twitter]

  ###############
  # VALIDATIONS #
  ###############
  validates :name, presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: /\A([[:alpha:]]|\w)+\z/ },
    length: {in: 2..25}
  validates :page_pref, inclusion: {:in => (1..100)}
  validates_associated :user_page
  #############
  # CALLBACKS #
  #############
  after_create :make_collections
  before_create :make_page
  before_validation :resolve_page_body
  after_initialize :load_page_body

  before_save :coerce_content_pref!
  ##############
  # ATTRIBUTES #
  ##############
  attr_accessor :page_body
  ####################
  # INSTANCE METHODS #
  ####################

  ##
  # See if the user is subscribed to a collection
  # Returns true or false
  # c:: the collection we are checking
  def subscribed_to? c
    # Coerce the subscription to a boolean
    !! Subscription.where(user: self,
                          collection: c).first
  end
  ##
  # Quickly get a user avatar, pre-resized
  def avatar_img
    avatar.f(:medium)
  end

  ##
  # Get a user's avatar thumbnail, pre-resized
  def avatar_img_thumb
    avatar.f(:small)
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
    creations.images << i
  end

  ##
  # Convenience method ot access the creations collection for a user
  def creations
    collections.creations.first
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
  # Put the user's page body into page_body.
  # This makes it a bit easier, since you can just say
  #     user.page_body
  # As opposed to
  #     user.page.body
  #
  # Ok, it's not that much easier, but still.
  def load_page_body
    page_body = self.user_page.body if self.user_page
  end

  ##
  # Create a page with a message indicating that the user hasn't set up their
  # page on user creation.
  def make_page
    build_user_page(body: "")
  end

  ##
  # Callback used to save the page_body in page.body on creation.
  def resolve_page_body
    return unless page_body
    user_page.body = page_body
    user_page.save
  end
  ##
  # All users have to have a Favorite collection and a Created collection.
  # This method makes both of those collections in a callback on user creation.
  def make_collections
    Favorite.create!(curators: [self])
    Creation.create!(curators: [self])
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
