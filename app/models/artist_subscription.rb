# frozen_string_literal: true
class ArtistSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist, class_name: "User"
  validate :not_subscribed_to_self
  after_create :notify_artist

  protected

  def notify_artist
    n = Notification.new(kind: :new_subscriber,
                         subject: user,
                         user: artist)
    n.save
  end

  def not_subscribed_to_self
    unless artist_id != user_id
      errors.add(:base, "cannot be to self")
    end
  end
end
