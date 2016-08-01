class Favorite < ApplicationRecord
  belongs_to :image, required: true
  belongs_to :user, required: true

  validates_presence_of :user
  validates_presence_of :image

  validates :user_id, uniqueness: { scope: :image_id }
end
