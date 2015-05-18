class TagGroupChange < ActiveRecord::Base
  belongs_to :tag_group
  belongs_to :user

  validates :user, presence: true
  validates :tag_group, presence: true

  enum kind: [:created, :updated]
end
