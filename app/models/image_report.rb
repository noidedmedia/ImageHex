class ImageReport < ActiveRecord::Base
  belongs_to :image
  belongs_to :user
  scope :active, ->{where(active: true)}
end
