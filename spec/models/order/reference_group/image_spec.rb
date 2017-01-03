require 'rails_helper'

RSpec.describe Order::ReferenceGroup::Image, type: :model do
  describe "validation" do
    it "requires an img" do
      expect(build(:order_reference_image,
                   img: nil)).to_not be_valid
    end
  end
end
