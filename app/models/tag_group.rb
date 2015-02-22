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
    array = self.tag_group_string.split(",")
      .map{|str| str.strip.squish.downcase} # Properly format the names
      .map{|str| Tag.where(name: str).first_or_create} # Create or find
    self.tags = array
  end

  ##
  # Makes a comma-sperated list of tags from actual tags
  def load_tag_group_string
    return unless self.tags.any?
    self.tag_group_string = self.tags.map(&:name).join(", ")
  end
end

