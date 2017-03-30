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
    join = <<-SQL
    INNER JOIN artist_subscriptions 
      ON notes.user_id = artist_subscriptions.artist_id
      SQL
    joins(join)
      .where("artist_subscriptions.user_id = ?",user.id)
      .order("notes.created_at DESC");
  end

  def self.use_relative_model_naming?
    true
  end

  def slug_candidates
    [
      [:title],
      [:title, :created_at]
    ]
  end

end

require_dependency 'note/reply'
