require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe "validation" do
    it "requires at least one category" do
      e = FactoryGirl.build(:listing,
                            categories: [],
                            categories_count: 0)
      expect(e).to_not be_valid
    end
  end

  describe "#make_open!" do
    let(:listing) { create(:listing) }
    it "sets the listing to open" do
      expect do
        listing.make_open!
      end.to change{listing.reload.open}.from(false).to(true)
    end
  end

  describe "#make_closed!" do
    let(:listing) { create(:open_listing) }
    it "sets the listing to closed" do
      expect do
        listing.make_closed!
      end.to change{listing.reload.open}.from(true).to(false)
    end
  end
end
