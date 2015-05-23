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
  default_scope { includes(:tags) }
  #################
  # RELATIONSHIPS #
  #################
  belongs_to :image
  has_many :tags, through: :tag_group_members
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
  attr_accessor :tag_group_string

  #############
  # CALLBACKS #
  #############
  before_validation :save_tag_group_string
  after_initialize :load_tag_group_string
  #################
  # CLASS METHODS #
  #################



  ####################
  # INSTANCE METHODS #
  ####################



  private
  ##
  # Converts a comma-seperated list of tags into the actual tags
  def save_tag_group_string
    return unless tag_group_string && ! tag_group_string.empty?
    tag_names = tag_group_string.split(",").map(&:strip).map(&:squish)
    formatted_tags = tag_names.map{|name| name.downcase.strip.squish}
    found_tags = formatted_tags.zip(tag_names).map do |names|
      ##
      # Names is currently an array of [formatted name, input name]
      # so we do this:
      if tag = Tag.where(name: names.first).first
        tag
      else
        tag = Tag.create(name: names.first,
                         display_name: names.last)
        tag.save
        tag
      end
    end
    self.tags = found_tags
  end

  ##
  # Makes a comma-sperated list of tags from actual tags.
  def load_tag_group_string
    return unless self.tags.any?
    self.tag_group_string = self.tags.map(&:name).join(", ")
  end
end

