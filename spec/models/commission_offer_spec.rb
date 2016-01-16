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
      subj = { description: "A description" }
      expect do
        FactoryGirl.build(:commission_offer,
                          commission_product: c,
                          subjects_attributes: (1..100).map { subj }).save!
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    context "without an offered backgrond" do
      let(:product) do
        FactoryGirl.create(:commission_product,
                           subject_price: 150,
                           offer_background: false,
                           include_background: false)
      end
      let(:at) do
        { description: "test" }
      end
      it "does not allow you to add a background" do
        c = FactoryGirl.build(:commission_offer,
                              commission_product: product,
                              subjects_attributes: [{ description: "test" }],
                              background_attributes: at)
        expect(c).to_not be_valid
      end
    end
    context "with limited subjects" do
      let(:product) do
        FactoryGirl.create(:commission_product,
                           subject_price: 0,
                           offer_subjects: false,
                           included_subjects: 3)
      end
      let(:subj) { { description: "test" } }
      it "can be under the limit" do
        expect(FactoryGirl.build(:commission_offer,
                                 commission_product: product,
                                 subjects_attributes: [subj])).to be_valid
      end
      it "cannot be over the limit" do
        o = FactoryGirl.build(:commission_offer,
                              commission_product: product,
                              subjects_attributes: 10.times.map { subj })
        expect(o.subjects.size).to be > product.included_subjects
        expect(o).to_not be_valid
      end
    end
    it "requires a user" do
      expect do
        FactoryGirl.create(:commission_offer,
                           user: nil)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  describe "confirmation" do
    let(:c) { FactoryGirl.create(:commission_offer) }
    it "has a method to confirm" do
      expect do
        c.confirm!
      end.to change { c.confirmed_at }
      expect(c.confirmed).to eq(true)
    end
    it "sends the artist a notification" do
      expect do
        c.confirm!
      end.to change { c.commission_product.user.notifications.count }.by(1)
    end
    it "creates a new conversation" do
      expect do
        c.confirm!
      end.to change { Conversation.count }.by(1)
      expect(Conversation.last.users).to contain_exactly(c.user,
                                                         c.offeree)
    end
  end
  describe "charging" do
    let(:product) do
      FactoryGirl.create(:commission_product,
                         weeks_to_completion: 4)
    end
    let(:offer) do
      FactoryGirl.create(:commission_offer,
                         commission_product: product)
    end
    it "stores the charge id" do
      expect do
        offer.charge!("fake_stripe_id")
      end.to change { offer.reload.stripe_charge_id }.to("fake_stripe_id")
    end

    it "sets the weeks to completion date" do
      Timecop.freeze do
        time = product.weeks_to_completion.weeks.from_now
        offer.charge!("fake_stripe_id")
        expect(offer.reload.due_at).to be_within(5.minutes).of(time)
      end
    end

    it "sets charged_at to Time.now" do
      Timecop.freeze do
        offer.charge!("fake_stripe_id")
        expect(offer.reload.charged_at).to be_within(5.minutes).of(Time.now)
      end
    end

    it "makes a new notification" do
      expect do
        offer.charge!("fake_stripe_id")
      end.to change { product.user.notifications.count }.by(1)
    end
  end
  describe "accepting" do
    it "accepts confirmed offers" do
      c = FactoryGirl.create(:commission_offer)
      c.confirm!
      expect do
        c.accept!
      end.to change { c.accepted_at }
      expect(c.accepted?).to eq(true)
    end
    it "does not accept unconfirmed offers" do
      c = FactoryGirl.create(:commission_offer)
      expect do
        c.accept!
      end.to_not change { c.accepted_at }
      expect(c.accepted?).to eq(false)
    end
    it "sends the commissioner a notification" do
      c = FactoryGirl.create(:commission_offer)
      c.confirm!
      expect do
        c.accept!
      end.to change { c.user.notifications.count }.by(1)
    end
  end
  describe ".involves" do
    let(:c) { create(:commission_offer) }
    it "is true for the offeree" do
      expect(c.involves?(c.offeree)).to eq(true)
    end
    it "is true for the offerer" do
      expect(c.involves?(c.user)).to eq(true)
    end
    it "is not true for randoms" do
      expect(c.involves?(create(:user))).to eq(false)
    end
  end

  describe "creation" do
    let(:subject_price) { 300 }
    let(:base_price) { 500 }
    context "with one subject but a paid background" do
      let(:background_price) { 400 }
      let(:product) do
        FactoryGirl.create(:commission_product,
                           base_price: base_price,
                           included_subjects: 1,
                           include_background: false,
                           background_price: background_price,
                           subject_price: subject_price,
                           maximum_subjects: 4)
      end
      let(:subject_attrs) do
        { description: "This is a subject" }
      end
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
                               background_attributes: { description: "test" })
        expect(f.total_price).to eq(base_price + background_price)
      end
    end
  end
end
