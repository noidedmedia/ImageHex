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
  scope :for_display, ->{joins(:tags).includes(:tags).order("ASCII(tags.display_name) ASC")}
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
  #################
  # CLASS METHODS #
  #################



  ####################
  # INSTANCE METHODS #
  ####################
  def tag_group_string
    self.tags.map(&:name).join(", ")
  end

  def tag_group_string=(str)
    @tgs = str.split(",").map do |s|
      s.downcase.strip.squish
    end
  end

  private
  ##
  # Converts a comma-seperated list of tags into the actual tags
  def save_tag_group_string
    return unless @tgs && ! @tgs.empty?
    found = @tgs.map do |name|
      if tag = Tag.where(name: name).first
        tag
      else
        Tag.create(name: name,
                   display_name: name)
      end
    end
    self.tags = found
  end
end

