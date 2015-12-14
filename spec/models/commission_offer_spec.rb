require 'rails_helper'

RSpec.describe CommissionOffer, type: :model do
  describe "validation" do
    it "requires a user" do
      expect{
        FactoryGirl.create(:commission_offer,
                           user: nil)
      }.to raise_error(ActiveRecord::StatementInvalid)
    end
    it "requires a commission product" do
      expect{
        FactoryGirl.create(:commission_offer,
                           commission_product: nil)
      }.to raise_error(ActiveRecord::StatementInvalid)
    end
  end
end
