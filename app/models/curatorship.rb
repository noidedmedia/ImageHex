# frozen_string_literal: true
##
# A curatorship is a join table between a user who curates a collection and the
# collections they curate.
# It also includes a level of curatorship for permissions purposes.
class Curatorship < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :collection, touch: true
  validates :user, presence: true
  validates :collection, presence: true
  validates :level, presence: true

  before_validation :set_default_level
  ##
  # Note that this is manually set in a callback on Collection
  # DO NOT MODIFY THIS WITHOUT ALSO MODIFYING THAT CALLBACK
  enum level: [:worker, :mod, :admin]

  ##
  # Allow the curatorship to be created with a user_name
  attr_accessor :user_name
  before_validation :resolve_user_name

  protected

  ##
  # Allow this to be created with a user_name
  # Makes the interface just a little bit nicer
  def resolve_user_name
    user ||= User.friendly.find(user_name) if user_name
  end

  def set_default_level
    self.level = :worker unless self.level
  end

end
