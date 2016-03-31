# frozen_string_literal: true
class ArtistSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist, class_name: "User"
  after_create :notify_artist

  protected

  def notify_artist
    n = Notification.new(kind: :new_subscriber,
                         subject: user,
                         user: artist)
    n.save
  end
end
