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
  protected
  def make_collections
    fav_name = "#{name.possessive} favorites"
    create_name = "#{name.possessive} creations"
    Collection.create!(user: self,
                       kind: Collection.kinds[:favorites], 
                       name: fav_name)
    Collection.create!(user: self, 
                       kind: Collection.kinds[:created], 
                       name: create_name)
  end

end
