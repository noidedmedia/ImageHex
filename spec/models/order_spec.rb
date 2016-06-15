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
        }.to_not change{order.final_price}
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

      let(:character_reference) do
          {
            listing_category_id: character_category.id,
            description: "This is a test"
          }
      end
      let(:order_attributes) do
        {
          user: create(:user),
          description: "This is a test",
          confirmed: true
        }
      end
      
      it "calculates the cost with a free reference" do
        attrs = {
          description: "test",
          references_attributes: [character_reference]
        }
        o = listing.orders.create!(order_attributes.merge(attrs))
        expect(o.send(:options_price)).to eq(0)
        expect(o.final_price).to eq(400)
      end

      it "calculates the cost with a nonfree reference" do
        attrs = {
          description: "test",
          references_attributes: 2.times.map{character_reference}
        }
        o = listing.orders.create!(order_attributes.merge(attrs))
        expect(o.final_price).to eq(400 + 100)
      end
    end
  end
end
