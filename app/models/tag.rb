# frozen_string_literal: true
##
# Represents a tag in the ImageHex database.
# Tags must have a unique name, and are not case sensative.
#
# Tags are formatted before saving to remove excess spaces ("do  thing" becomes
# "do thing"), trailing and leading whitespace " do thing " becomes "do thing"),
class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  ##
  # CALLBACKS:
  before_validation :fix_name, on: :create
  ##
  # SCOPES
  scope :by_importance, -> { order(importance: :desc) }
  ##
  # ASSOCIATIONS:
  has_many :tag_group_members
  has_many :tag_groups, through: :tag_group_members
  has_many :images, -> { order(created_at: :desc) }, through: :tag_groups
  validates :name, uniqueness: { case_sensative: false }
  validates :importance, inclusion: { in: (0..5) }
  ##
  # Suggest tags beginning with a string.
  # Tags are returned alphabetically.
  # Returns 10 tags at a time.
  # Usage:
  #   Tag.suggest("ha") => ["hack", "halloween"]
  def self.suggest(n)
    query = %Q{
    SELECT tags.name, tags.id, tags.importance  FROM tags
    WHERE tags.name LIKE ?
    ORDER BY importance ASC
    }
    finder = "#{n.delete('%').downcase.strip.squish}%"
    find_by_sql([query, finder])
  end

  ####################
  # INSTANCE METHODS #
  ####################
  
  def should_generate_new_friendly_id?
    name_changed?
  end

  def often_seen_with
    g = tag_groups
    Tag.joins(tag_group_members: :tag_group)
      .where(tag_groups: { image_id: g.select(:image_id) })
      .where.not(tag_groups: { id: g.select(:id) })
      .group(:id)
      .order("COUNT(*) DESC")
      .select("tags.*, COUNT(*) AS count")
  end

  ##
  # Neighbors provides a list of tags that are commonly used
  # with this tag.
  def neighbors
    Tag.joins(:tag_group_members)
      .where(tag_group_members: { tag_group_id: tag_groups })
      .where.not(id: self)
      .group(:id)
      .order("COUNT(*) DESC")
      .select("tags.*, COUNT(*) AS count")
  end

  private

  ##
  # Callback which formats the name.
  def fix_name
    self.name = name.strip.squish
  end
end
