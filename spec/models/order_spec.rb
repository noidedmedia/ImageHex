require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validation" do
    let(:listing) { create(:listing) }
    it "does not allow orders to one's self" do
      expect(build(:order, 
                   user: listing.user,
                   listing: listing)).to_not be_valid
    end

    it "requires itself to have some references" do
      o = build(:order)
      o.references = []
      expect(o).to_not be_valid
    end
  end

  describe "cost calculation" do
    context "on quote listings" do
      let(:listing) { create(:quote_listing) }
      let(:order) do
        build(:order,
              listing: listing)
      end
      it "does not set on creation" do
        expect{
          order.save
        }.to_not change{order.final_cost}
      end
    end

    context "on normal listings" do
      let(:listing) { create(:listing) }

    end
  end
end
