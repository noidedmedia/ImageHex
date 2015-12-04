class ArtistSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist, class_name: "User"
end
