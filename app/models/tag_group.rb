class TagGroup < ActiveRecord::Base
  #################
  # RELATIONSHIPS #
  #################
  belongs_to :image
  has_many :tags, through: :tag_group_members
  has_many :tag_group_members

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
    return unless self.tag_group_string && ! self.tag_group_string.empty?
    tag_names = self.tag_group_string.split(",")
    tag_names.map!(&:strip)
    formated_tags = tag_names.map{|name| name.downcase.strip.squish}
    found_tags = formated_tags.zip(tag_names).map do |names|
      ##
      # Names is currently an array of [formated name, input name]
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
  # Makes a comma-sperated list of tags from actual tags
  def load_tag_group_string
    return unless self.tags.any?
    self.tag_group_string = self.tags.map(&:name).join(", ")
  end
end

