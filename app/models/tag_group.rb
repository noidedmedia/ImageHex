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
    formated_tags = tag_names.map{|name| name.downcase.strip.squish}
    found_tags = formated_tags.zip(tag_names).map do |names|
      ##
      # Names is currently an array of [formated name, input name]
      # so we do this:
      Tag.where(name: names.first).first_or_create do
        display_name = names.last
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

