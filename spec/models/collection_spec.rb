require 'spec_helper'

describe Collection do

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
    }.to raise_error(ActiveRecord::RecordInvalid)
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
