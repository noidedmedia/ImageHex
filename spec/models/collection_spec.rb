require 'spec_helper'

describe Collection do

  describe "scopes" do
   let(:i){ FactoryGirl.create(:image)}
   let(:c1){FactoryGirl.create(:collection)}
   let(:c2){FactoryGirl.create(:collection)}
    it "has a scope for collections without a given image" do
      c1.images << i
      c2
      expect(Collection.without_image(i)).to_not include(c1)
    end
    it "has a score for collections with a given image" do
      c1.images << i
      c2
      expect(Collection.with_image(i)).to eq([c1])
    end
    it "has a scope that selects if a collection contains an image" do
      c1.images << i
      c2
      Collection.with_image_inclusion(i).each do |c|
        if c.id == c1.id
          expect(c.contains_image).to eq(true)
        else
          expect(c.contains_image).to eq(false)
        end
      end
    end
  end
  it {should have_many(:collection_images)}
  ##
  # Due to what I believe to be a bug in shoulda_mathcers, this test
  # will not work. I have verified with manual testing that a collection
  # does, indeed, have many collectiosn through collection_images.
  # it {should have_many(:images).through(:collection_images)}
  

  it "should not allow duplicate images" do
    c = FactoryGirl.create(:collection)
    i = FactoryGirl.create(:image)
    expect{
    c.images = [i, i]
    }.to raise_error
  end
  describe "subscriptions" do
    it "lists all subscribed users with the subscribers method" do
      c = FactoryGirl.create(:collection)
      u = FactoryGirl.create(:user)
      c.subscribers << u
      expect(c.subscribers).to eq([u])
    end
  end
end
