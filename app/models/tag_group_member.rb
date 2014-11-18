class TagGroupMember < ActiveRecord::Base
  belongs_to :tag_group
  belongs_to :tag
end
