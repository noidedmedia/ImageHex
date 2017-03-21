class Note < ApplicationRecord
  extend FriendlyId

  friendly_id :slug_candidates, 
    use: :slugged

  belongs_to :user, required: true

  validates :title, 
    presence: true, 
    allow_blank: false

  validates :body,
    presence: true,
    allow_blank: false


  def slug_candidates
    [
      [:user_name, :title],
      [:user_name, :title, :created_at]
    ]
  end

  def user_name
    user.name
  end
end
