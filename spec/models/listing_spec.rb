# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe ".for_search" do
    describe "background filtering" do
      before(:each) do
        @i_b = create(:listing,
                      include_background: true)
        @o_b = create(:listing,
                      offer_background: true)
        @n_b = create(:listing,
                      offer_background: false,
                      include_background: false)
      end
      it "includes results with a background if instructed" do
        c = Listing.for_search("has_background" => true)
        expect(c).to contain_exactly(@i_b, @o_b)
      end
    end
  end

  describe "validations" do
    it "requires price to be at least $3.50" do
      expect do
        FactoryGirl.build(:listing,
                          base_price: 100).save!
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "requires the user to be set" do
      expect do
        FactoryGirl.create(:listing,
                           user: nil)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
