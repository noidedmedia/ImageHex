require 'rails_helper'

RSpec.describe CommissionProduct, type: :model do
  describe "validations" do
    it "requires price to be at least $3.50" do
      expect{
        FactoryGirl.create(:commission_product,
                           price: 100)
      }.to raise_error
    end
  end
end
