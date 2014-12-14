require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  # Page pref has to be a sensable value
  it {should validate_inclusion_of(:page_pref).in_range(1..100)}
  # Validations for the name
  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name).case_insensitive}
  # Has many images
  it {should have_many(:images)}

  describe "creation" do
    it "gives the user a favorites and created collection" do
      expect{FactoryGirl.create(:user)}.to change{Collection.count}.by(2)
      u = FactoryGirl.create(:user)
      expect(u.collections.where(kind:
                                 Collection.kinds["favorites"]).size).to eq(1)
      expect(u.collections.where(kind:
                                 Collection.kinds["creations"]).size).to eq(1)
    end
  end

  describe "favoriting" do
    let(:u){FactoryGirl.create(:user)}
    let(:i){FactoryGirl.create(:image)}
    
    it "adds an image to the favorites" do
      u.favorite!(i)
      expect(u.favorites).to eq([i])
    end
    it "has a shorthand method for accessing the favorites collection" do
      expect(u.favorites_collection.kind).to eq("favorites")
    end
    it "has a shorthand method for accessing favorite images" do
      expect(u.favorites).to eq(u.favorites_collection.images)
    end
  end
  describe "creation" do
    let(:u){FactoryGirl.create(:user)}
    let(:i){FactoryGirl.create(:image)}
    it "adds an image to creations" do
      u.created!(i)
      expect(u.creations).to eq([i])
    end
    it "has a shorthand for accessing the creations collection" do
      expect(u.creations_collection.kind).to eq("creations")
    end
    it "has a shorthand method for accessing created images" do
      expect(u.creations).to eq(u.creations_collection.images)
    end

  end
end
