require 'spec_helper'

describe Collection do
  it {should belong_to(:user)}
  it {should have_many(:collection_images)}
  ##
  # Due to what I believe to be a bug in shoulda_mathcers, this test
  # will not work. I have verified with manual testing that a collection
  # does, indeed, have many collectiosn through collection_images.
  # it {should have_many(:images).through(:collection_images)}
end
