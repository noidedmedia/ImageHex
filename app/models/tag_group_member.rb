class TagGroupMember < ActiveRecord::Base
  belongs_to :tag_group
  belongs_to :tag
  validates :tag, presence: true
  validates :tag_group, presence: true
end
