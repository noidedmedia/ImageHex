class TagGroup < ActiveRecord::Base
  belongs_to :image
  has_many :tags, through: :tag_group_members
  has_many :tag_group_members
end
