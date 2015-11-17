require 'spec_helper'

describe User do

  # Page pref has to be a sensable value
  it {should validate_inclusion_of(:page_pref).in_range(1..100)}
  # Validations for the name
  it {should validate_presence_of(:name)}
  # Has many images
  it {should have_many(:images)}
  describe "avatars" do
    it "Should allow image avatars" do
      u = FactoryGirl.create(:user)
      u.avatar = Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "test.jpg"), "image/jpg")
      expect(u).to be_valid
    end
    it "does not allow evil js or other things" do
      u = FactoryGirl.create(:user)
      u.avatar = Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "evil.js"), "application/javascript")
      expect(u).to_not be_valid
    end
  end 
  describe "curatorships" do
    let(:u){FactoryGirl.create(:user)}
    let(:c){FactoryGirl.create(:collection)}
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
    let(:u){FactoryGirl.create(:user)}
    let(:c){FactoryGirl.create(:collection)}
    it "has a method to subscribe" do
      u.subscribe!(c)
      expect(u.subscribed_collections).to eq([c])
      expect(c.subscribers).to eq([u])
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
    it "gives the user a favorites and created collection" do
      expect{FactoryGirl.create(:user)}.to change{Collection.count}.by(2)
      u = FactoryGirl.create(:user)
      expect(u.collections.favorites.size).to eq(1)
      expect(u.collections.creations.size).to eq(1)
    end
  end

  describe "favoriting" do
    let(:u){FactoryGirl.create(:user)}
    let(:i){FactoryGirl.create(:image)}

    it "adds an image to the favorites" do
      u.favorite!(i)
      expect(u.favorites.images).to eq([i])
    end
  end
  describe "creation" do
    let(:u){FactoryGirl.create(:user)}
    let(:i){FactoryGirl.create(:image)}
    it "adds an image to creations" do
      u.created!(i)
      expect(u.creations.images).to eq([i])
    end

  end
end
