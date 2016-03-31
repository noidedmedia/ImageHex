# frozen_string_literal: true
require 'spec_helper'

describe User do
  # Page pref has to be a sensable value
  it { should validate_inclusion_of(:page_pref).in_range(10..100) }
  # Validations for the name
  it { should validate_presence_of(:name) }
  # Has many images
  it { should have_many(:images) }
  describe "avatars" do
    it "Should allow image avatars" do
      u = FactoryGirl.create(:user)
      path = Rails.root.join("spec", "fixtures", "files", "test.jpg")
      u.avatar = Rack::Test::UploadedFile.new(path, "image/jpg")
      expect(u).to be_valid
    end
    it "does not allow evil js or other things" do
      u = FactoryGirl.create(:user)
      path = Rails.root.join("spec", "fixtures", "files", "evil.js")
      u.avatar = Rack::Test::UploadedFile.new(path, "application/javascript")
      expect(u).to_not be_valid
    end
  end
  describe "curatorships" do
    let(:u) { FactoryGirl.create(:user) }
    let(:c) { FactoryGirl.create(:collection) }
    it "gives back the curatorship" do
      cur = Curatorship.create(user: u,
                               collection: c)
      expect(u.curatorship_for(c)).to eq(cur)
    end
    it "gives a null curatorship if no curatorship exists" do
      expect(u.curatorship_for(c)).to eq(nil)
    end
  end
  describe "subscriptions" do
    let(:u) { FactoryGirl.create(:user) }
    let(:c) { FactoryGirl.create(:collection) }
    describe ".subscribe!" do
      it "works with collections" do
        u.subscribe!(c)
        expect(u.subscribed_collections).to eq([c])
        expect(c.subscribers).to eq([u])
      end
      it "works with users" do
        u2 = FactoryGirl.create(:user)
        u.subscribe! u2
        # a fan of bono apparently
        expect(u.subscribed_artists).to eq([u2])
        expect(u2.subscribers).to eq([u])
      end
    end
    describe ".unsubscribe!" do
      it "works with collections" do
        u.subscribe! c
        expect(u.subscribed_collections).to include(c)
        u.unsubscribe! c
        expect(u.subscribed_collections).to_not include(c)
      end
      it "works with users" do
        u2 = FactoryGirl.create(:user)
        u.subscribe! u2
        expect(u.subscribed_artists).to include(u2)
        u.unsubscribe! u2
        expect(u.subscribed_artists).to_not include(u2)
      end
    end
    it "has many subscribed collections" do
      c2 = FactoryGirl.create(:collection)
      u.subscribe! c
      u.subscribe! c2
      expect(u.subscribed_collections).to match_array([c, c2])
    end
    it "provides all images in a user's feed in order" do
      i1 = FactoryGirl.create(:image)
      c.images << i1
      u.subscribe! c
      c2 = FactoryGirl.create(:collection)
      i2 = FactoryGirl.create(:image)
      c2.images << i2
      u.subscribe! c2
      expect(u.image_feed).to eq([i2, i1])
    end
  end
  describe "creation" do
    it "gives the user a favorites collection" do
      expect { FactoryGirl.create(:user) }.to change { Collection.count }.by(1)
      u = FactoryGirl.create(:user)
      expect(u.collections.favorites.size).to eq(1)
    end
  end

  describe "favoriting" do
    let(:u) { FactoryGirl.create(:user) }
    let(:i) { FactoryGirl.create(:image) }

    it "adds an image to the favorites" do
      u.favorite!(i)
      expect(u.favorites.images).to eq([i])
    end
  end
  describe "creation" do
    let(:u) { FactoryGirl.create(:user) }
    let(:i) { FactoryGirl.create(:image) }
    it "adds an image to creations" do
      u.created!(i)
      expect(u.creations).to eq([i])
    end
  end
end
