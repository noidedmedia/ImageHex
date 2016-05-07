require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validation" do
    let(:listing) { create(:listing) }
    it "does not allow orders to one's self" do
      expect(build(:order, 
                   user: listing.user,
                   listing: listing)).to_not be_valid
    end
  end
end
