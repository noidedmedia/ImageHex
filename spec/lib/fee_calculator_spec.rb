require 'rails_helper'

RSpec.describe FeeCalculator do
  context "with a normal fee" do
    let(:listing) { create(:listing) }
    let(:order) { create(:order, final_price: 1000) }
    let(:calculator) { FeeCalculator.new(listing, order) }
    it "calculates the fee" do
      expect(calculator.fee).to eq(130)
    end
  end
end
