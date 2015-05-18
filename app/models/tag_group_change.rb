class TagGroupChange < ActiveRecord::Base
  belongs_to :tag_group
  belongs_to :user

  valdiates :user, presence: true
  validates :tag_group, presence: true
end
