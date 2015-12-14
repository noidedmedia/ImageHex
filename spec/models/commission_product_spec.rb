require 'rails_helper'

RSpec.describe CommissionProduct, type: :model do
  describe "validations" do
    it "requires price to be at least $3.50" do
      expect{
        FactoryGirl.build(:commission_product,
                           base_price: 100).save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "requires the user to be set" do
      expect{
        FactoryGirl.create(:commission_product,
                           user: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
