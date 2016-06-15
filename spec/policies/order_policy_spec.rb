require 'rails_helper'

RSpec.describe OrderPolicy do

  let(:user) { create(:user) }

  subject { described_class }

  permissions :show? do
    let(:artist){ create(:user) }
    let(:listing) do
      create(:listing, user: artist)
    end
    let(:customer){ create(:user) }
    let(:random){ create(:user) }
    context "when order is confirmed" do
      let(:order) do
        create(:order,
               user: customer,
               listing: listing,
               confirmed: true)
      end
      it "works for artist of the listing" do
        expect(subject).to permit(artist, order)
      end
      it "works for the customer" do
        expect(subject).to permit(customer, order)
      end
      it "doesn't work for randoms" do
        expect(subject).to_not permit(random, order)
      end
    end
    context "when order is unconfirmed" do
      let(:order) do
        create(:order,
               user: customer,
               listing: listing,
               confirmed: false)
      end

      it "works for the customer" do
        expect(subject).to permit(customer, order)
      end

      it "does not work for the artist" do
        expect(subject).to_not permit(artist, order)
      end

      it "doesn't work for randoms" do
        expect(subject).to_not permit(random, order)
      end
    end
  end

  permissions :create? do
  end

  permissions :update? do
  end

  permissions :destroy? do
  end
end
