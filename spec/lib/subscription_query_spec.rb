# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SubscriptionQuery do
  let(:user) { FactoryGirl.create(:user) }
  let(:artist) { FactoryGirl.create(:user) }
  let(:collection) { create(:collection) }
  let(:image_a) { FactoryGirl.create(:image) }
  let(:image_b) { FactoryGirl.create(:image) }
  let(:image_c) { FactoryGirl.create(:image) }
  it "shows all subscribed collection images and artist images" do
    artist.created! image_a
    user.subscribe! artist
    collection.images << image_b
    expect(SubscriptionQuery.new(user).result).to eq([image_a])
    user.subscribe! collection
    expect(SubscriptionQuery.new(user).result).to contain_exactly(image_a,
                                                                  image_b)
  end
end
