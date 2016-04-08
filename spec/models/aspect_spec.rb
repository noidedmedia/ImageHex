require 'rails_helper'

RSpec.describe Aspect, type: :model do
  describe "validation" do
    let(:listing) { create(:listing_with_options) }
    let(:option) { listing.options.first } 
    let(:bad_option) { create(:option) }
    let(:offer) { create(:offer, listing: listing) }
    it "must be for an option in this listing" do
      good = build(:aspect, offer: offer, option: option)
      expect(good).to be_valid
      bad = build(:aspect, offer: offer, option: bad_option)
      expect(bad).to_not be_valid
    end
  end
end
