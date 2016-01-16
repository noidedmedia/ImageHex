##
# Groups together a bunch of images on a tag.
#
# Has 3 relations:
# image:: The image this tag group is on
# tags:: Via a has_many through: with tag_group_members, shows what tags
#        are in this group.
# tag_group_members:: Join table for a has_many through (tags <-> tag_groups)
# TODO: Add a relation to connect a tag_group to the most recent user who
# updated it.
#
# This model also has an attribute called "tag_group_string". It's a
# comma-seperated list of tags. This is the user's primary way of interacting
# with the tags on ImageHex. If a tag in the list is non-existent on
# saving the tag_group, it will be formated properly and created. Neat, huh?
class TagGroup < ActiveRecord::Base
  scope :for_display, -> { joins(:tags).includes(:tags).order("tags.importance DESC") }
  #################
  # RELATIONSHIPS #
  #################
  belongs_to :image
  has_many :tags, -> { by_importance }, through: :tag_group_members
  has_many :tag_group_members
  has_many :tag_group_changes
  ###############
  # VALIDATIONS #
  ###############
  validates :image, presence: true
  validates :tags, presence: true

  ##############
  # ATTRIBUTES #
  ##############
  attr_accessor :tag_ids

  #############
  # CALLBACKS #
  #############
  before_validation :save_tag_ids
  #################
  # CLASS METHODS #
  #################

  ####################
  # INSTANCE METHODS #
  ####################

  private

  ##
  # Converts a comma-seperated list of tags into the actual tags
  def save_tag_ids
    self.tags = Tag.where(id: tag_ids)
  end
end
