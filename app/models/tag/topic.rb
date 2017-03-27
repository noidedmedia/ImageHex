class Tag::Topic < ApplicationRecord
  extend FriendlyId
  include Replyable

  friendly_id :slug_candidates, use: :slugged

  belongs_to :tag, required: true

  belongs_to :user, required: true

  has_many :replies,
    foreign_key: :tag_topic_id,
    inverse_of: :topic

  def parent_name
    tag.name
  end

  def parent
    tag
  end

  def slug_candidates
    [
      [:created_at, :title],
      [:created_at, :title, :user_id]
    ]
  end

  def self.use_relative_model_naming?
    true
  end
end
