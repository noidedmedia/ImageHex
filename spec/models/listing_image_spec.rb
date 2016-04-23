require 'rails_helper'

RSpec.describe ListingImage, type: :model do
  describe "validation" do
    it "requires the image and listing to share an owner" do
      user_a = create(:user)
      user_b = create(:user)
      img = create(:image, user: user_a)
      list = create(:listing, user: user_b)
      expect(build(:listing_image,
                   listing: list,
                   image: img)).to_not be_valid
    end
  end
end
