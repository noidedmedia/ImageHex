# frozen_string_literal: true
##
# This is a plain-jane join table. It maps tags <-> tag_groups.
# Not very exciting, never interacted with directly (at the moment, we may
# need to touch it for filters), kind of boring. Not that bad, though.
class TagGroupMember < ActiveRecord::Base
  belongs_to :tag_group, 
    touch: true,
    inverse_of: :tag_group_members
  belongs_to :tag,
    inverse_of: :tag_group_members
  validates :tag, presence: true
  validates :tag_group, presence: true
  after_create :touch_group

  protected

  def touch_group
    tag_group.touch
  end
end
