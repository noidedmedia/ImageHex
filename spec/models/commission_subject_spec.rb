require 'rails_helper'

RSpec.describe CommissionSubject, type: :model do
  describe "validation" do
    it "requires its offer to be set" do
      expect(FactoryGirl.build(:commission_subject,
                                commission_offer: nil)).to_not be_valid
    end
  end

  describe "saving" do
    it "saves the tags in tag_ids" do
      expect{
        FactoryGirl.create(:commission_subject,
                           tag_ids: [FactoryGirl.create(:tag).id])
      }.to_not raise_error
    end
  end
end
