class User < ActiveRecord::Base
  ################
  # ASSOCIATIONS #
  ################
  has_many :images
  has_many :collections 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable

  ###############
  # VALIDATIONS #
  ###############
  validates :name, presence: true,  uniqueness: {case_sensitive: false}
  validates :page_pref, inclusion: {:in => (1..100)}

  #############
  # CALLBACKS #
  #############
  after_create :make_collections


  ####################
  # INSTANCE METHODS #
  ####################

  ##
  # The collection that holds our favorites
  def favorites_collection
    collections.where(kind: Collection.kinds["favorites"]).first
  end
  ##
  # Add an image to a user's favorites
  def favorite! i
    favorites.append(i)
  end

  ##
  # All the images in a user's favorites collection
  def favorites
    favorites_collection.images
  end

  ##
  # The collection that holds all images our user has created
  def creations_collection
    collections.where(kind: Collection.kinds["creations"]).first
  end

  ## 
  # Add an image to a user's creations
  def created! i
    creations.append(i)
  end

  def creations
    creations_collection.images
  end
  protected
  def make_collections
    fav_name = "#{name.possessive} favorites"
    create_name = "#{name.possessive} creations"
    Collection.create!(user: self,
                       kind: Collection.kinds["favorites"], 
                       name: fav_name)
    Collection.create!(user: self, 
                       kind: Collection.kinds["creations"], 
                       name: create_name)

  end
  enum role: [:normal, :admin]
end
