require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe "validation" do
    let(:listing){ build(:listing) }
    it "requires one referece option" do
      option = build(:option,
                     listing: listing,
                     reference_category: false)
      listing.options = [option]
      expect(listing).to_not be_valid
    end
  end
end
