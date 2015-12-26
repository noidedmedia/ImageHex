require 'rails_helper'

RSpec.describe CommissionOffer, type: :model do
  describe "validation" do
    it "does not allow you to offer to yourself" do
      p = FactoryGirl.create(:commission_product)
      c = FactoryGirl.build(:commission_offer,
                            commission_product: p,
                            user_id: p.user_id)
      expect(p.user).to eq(c.user)
      expect(c).to_not be_valid
    end
    it "breaks with subjects over the maximum" do
      c = FactoryGirl.create(:commission_product,
                             maximum_subjects: 3)
      subj  = {description: "A description"}
      expect{
        FactoryGirl.build(:commission_offer,
                          commission_product: c,
                          subjects_attributes: (1..100).map{subj}).save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    context "without an offered backgrond" do
      let(:product){
        FactoryGirl.create(:commission_product,
                           subject_price: 150,
                           offer_background: false,
                           include_background: false)
      }
      let(:at){
        {description: "test"}
      }
      it "does not allow you to add a background" do
        c = FactoryGirl.build(:commission_offer,
                              commission_product: product,
                              subjects_attributes: [{description: "test"}],
                              backgrounds_attributes: [at])
        expect(c).to_not be_valid
      end
    end
    context "with limited subjects" do
      let(:product){
        FactoryGirl.create(:commission_product,
                           subject_price: 0,
                           offer_subjects: false,
                           included_subjects: 3)
      }
      let(:subj){ {description: "test"} }
      it "can be under the limit" do
        expect(FactoryGirl.build(:commission_offer,
                                 commission_product: product,
                                 subjects_attributes: [subj])).to be_valid
      end
      it "cannot be over the limit" do
        o = FactoryGirl.build(:commission_offer,
                              commission_product: product,
                              subjects_attributes: 10.times.map{subj})
        expect(o.subjects.size).to be > product.included_subjects
        expect(o).to_not be_valid
      end
    end
    it "requires a user" do
      expect{
        FactoryGirl.create(:commission_offer,
                           user: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "requires a commission product" do
      expect{
        FactoryGirl.create(:commission_offer,
                           commission_product: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  describe "confirmation" do
    it "has a method to confirm" do
      c = FactoryGirl.create(:commission_offer)
      expect{
        c.confirm!
      }.to change{c.confirmed_at}
      expect(c.confirmed).to eq(true)
    end
    it "sends the artist a notification" do
      c = FactoryGirl.create(:commission_offer)
      expect{
        c.confirm!
      }.to change{c.commission_product.user.notifications.count}.by(1)
    end
  end

  describe "accepting" do
    it "accepts confirmed offers" do
      c = FactoryGirl.create(:commission_offer)
      c.confirm!
      expect{
        c.accept!
      }.to change{c.accepted_at}
      expect(c.accepted?).to eq(true)
    end
    it "does not accept unconfirmed offers" do
      c = FactoryGirl.create(:commission_offer)
      expect{
        c.accept!
      }.to_not change{c.accepted_at}
      expect(c.accepted?).to eq(false)
    end
    it "sends the commissioner a notification" do
      c = FactoryGirl.create(:commission_offer)
      c.confirm!
      expect{
        c.accept!
      }.to change{c.user.notifications.count}.by(1)
    end
  end
  describe "creation" do
    let(:subject_price){300}
    let(:base_price){500}
    context "with one subject but a paid background" do
      let(:background_price){400}
      let(:product){
        FactoryGirl.create(:commission_product,
                           base_price: base_price,
                           included_subjects: 1,
                           include_background: false,
                           background_price: background_price,
                           subject_price: subject_price,
                           maximum_subjects: 4)
      }
      let(:subject_attrs){
        {description: "This is a subject"}
      }
      it "does not charge for the included subject" do
        f = FactoryGirl.create(:commission_offer,
                               commission_product: product,
                               subjects_attributes: [subject_attrs])
        expect(f.total_price).to eq(base_price)
      end
      it "does charge for extra subjects" do
        f = FactoryGirl.create(:commission_offer,
                               commission_product: product,
                               subjects_attributes: [subject_attrs,
                                 subject_attrs])
        expect(f.total_price).to eq(base_price + subject_price)
      end
      it "charges for a background" do
        f = FactoryGirl.create(:commission_offer,
                               commission_product: product,
                               subjects_attributes: [subject_attrs],
                               backgrounds_attributes: [{description: "test"}])
        expect(f.total_price).to eq(base_price + background_price)
      end
    end
  end
end
