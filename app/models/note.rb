class Note < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user, required: true

  validates :title, 
    presence: true, 
    allow_blank: false

  validates :body,
    presence: true,
    allow_blank: false

end
