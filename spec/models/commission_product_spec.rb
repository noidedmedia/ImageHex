require 'rails_helper'

RSpec.describe CommissionProduct, type: :model do
  describe ".for_search" do
    describe "background filtering" do
      before(:each) do
        @i_b = create(:commission_product,
                      include_background: true)
        @o_b = create(:commission_product,
                      offer_background: true)
        @n_b = create(:commission_product,
                      offer_background: false,
                      include_background: false)
      end
      it "includes results with a background if instructed" do
        c = CommissionProduct.for_search("has_background" => true)
        expect(c).to contain_exactly(@i_b, @o_b)
      end
    end
  end

  describe "validations" do
    it "requires price to be at least $3.50" do
      expect do
        FactoryGirl.build(:commission_product,
                          base_price: 100).save!
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "requires the user to be set" do
      expect do
        FactoryGirl.create(:commission_product,
                           user: nil)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
