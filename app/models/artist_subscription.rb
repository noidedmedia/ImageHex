class ArtistSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist, class_name: "User"
  after_create :notify_artist

  protected
  def notify_artist
    n = Notification.new(kind: :new_subscriber,
                         subject: self.user,
                         user: self.artist)
    n.save
  end
end
