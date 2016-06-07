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
      let(:listing) { create(:listing, base_price: 400) }

      let(:character_category) do 
        create(:listing_category,
               listing: listing,
               price: 100,
               free_count: 1)
      end

      let(:shading_option) do
        create(:listing_option,
               listing: listing,
               price: 500)
      end

      let(:options_attributes) do
        {listing_option_id: shading_option.id}
      end

      let(:references_attributes) do
        2.times.map do
          {
            listing_category_id: character_category.id,
            description: "This is a test"
          }
        end
      end

      let(:order) do
        Order.new(description: "This is a test",
                  references_attributes: references_attributes,
                  options_attributes: options_attributes)
      end
      it "calculates the cost properly" do
        o = order.save!
        expect(o.price).to eq(400 + 100 + 500)
      end
    end
  end
end
