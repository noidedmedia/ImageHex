class Note < ApplicationRecord
  extend FriendlyId
  include Replyable

  friendly_id :slug_candidates, 
    use: :slugged

  belongs_to :user, required: true

  validates :title, 
    presence: true, 
    allow_blank: false

  validates :body,
    presence: true,
    allow_blank: false


  def self.feed_for(user)
    where(user: user.subscribed_artists)
  end


  def slug_candidates
    [
      [:title],
      [:title, :created_at]
    ]
  end

end

require_dependency 'note/reply'
