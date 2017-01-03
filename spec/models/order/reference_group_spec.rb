require 'rails_helper'

RSpec.describe Order::ReferenceGroup, type: :model do
  describe "validation" do
    it "requires category be on the proper listing" do
      order = create(:order)
      bad_listing = create(:listing)
      expect(build(:order_reference,
                   order: order,
                   category: bad_listing.categories.sample)).to_not be_valid
    end
  end
end
