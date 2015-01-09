require 'spec_helper'

describe User do
  
  # Page pref has to be a sensable value
  it {should validate_inclusion_of(:page_pref).in_range(1..100)}
  # Validations for the name
  it {should validate_presence_of(:name)}
  # Has many images
  it {should have_many(:images)}

  describe "subscriptions" do
    let(:u){FactoryGirl.create(:user)}
    let(:c){FactoryGirl.create(:collection)}
    it "has a method to subscribe" do
      u.subscribe!(c)
      expect(u.subscribed_collections).to eq([c])
      expect(c.subscribers).to eq([u])
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
