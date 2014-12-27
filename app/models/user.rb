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
  def make_collections
    Favorite.create!(user: self)
    Creation.create!(user: self)
  end
  enum role: [:normal, :admin]
end
