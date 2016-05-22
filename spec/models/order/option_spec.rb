require 'rails_helper'

RSpec.describe Order::Option, type: :model do
  describe "validation" do
    let(:listing) { create(:listing) }
    it "cannot be for a option not on the listing" do
      expect(build(:order_option,
                   option: create(:listing_option))).to_not be_valid
    end
  end
end
