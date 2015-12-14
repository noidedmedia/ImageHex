require 'rails_helper'

RSpec.describe ArtistSubscription, type: :model do
  it "notifies the artist" do
    u = FactoryGirl.create(:user)
    expect{
      c = FactoryGirl.create(:artist_subscription,
                             artist: u)
    }.to change{u.notifications.count}.by(1)
    expect(u.notifications.last.kind).to eq("new_subscriber")
  end
end
