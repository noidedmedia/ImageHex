##
# A curatorship is a join table between a user who curates a collection and the
# collections they curate.
# It also includes a level of curatorship for permissions purposes.
class Curatorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection
  validates :user, presence: true
  validates :collection, presence: true
  validates :level, presence: true

  ##
  # Note that this is manually set in a callback on Collection
  # DO NOT MODIFY THIS WITHOUT ALSO MODIFYING THAT CALLBACK
  enum level: [:worker, :mod, :admin]

  ##
  # Allow the curatorship to be created with a user_name
  attr_accessor :user_name
  before_save :resolve_user_name

  protected
  ##
  # Allow this to be created with a user_name
  # Makes the interface just a little bit nicer
  def resolve_user_name
    user ||= User.friendly.find(user_name) if user_name
  end
end
