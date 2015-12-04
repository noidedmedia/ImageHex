require 'pry'
##
# This class tracks changes to a tag_group. 
#
# == Members
# kind:: an enum represtending what kind of change this is. Can be in
#        `[:created, :update]`
# before:: an array of ids of tags. Represents the group before the edit was made.
# after:: an array of ids of tags. Represents the group after.
# == Relations
# user:: the user who made the edit
# tag_group:: the tag_group we're tracking changes on
class TagGroupChange < ActiveRecord::Base
  scope :for_display, ->{ order("created_at DESC") }
  
  belongs_to :tag_group
  belongs_to :user

  validates :user, presence: true
  validates :tag_group, presence: true

  enum kind: [:created, :updated]

  ####################
  # INSTANCE METHODS #
  ####################
  
  ##
  # The tags before the edit was made.
  # Memoized, so you can call it many times in a row.
  def before_tags
    @_before_tags ||= Tag.where(id: before)
  end

  ##
  # The tags after the edit was made.
  # Memorized, so you can call it many times in a row
  def after_tags
    @_after_tags ||= Tag.where(id: after)
  end

  ## 
  # The tags which this edit added
  def added_tags
    after_tags - before_tags
  end

  ##
  # The tags which this edit removed
  def removed_tags
    before_tags - after_tags
  end

  ##
  # The tags which were unchanged in this edit
  def unchanged_tags
    before_tags & after_tags
  end

  ##
  # A method which reverts this edit, restoring the tag_group to the
  # `before` state.
  def revert!
    tag_group.tag_ids = before
    tag_group.save!
  end
end
