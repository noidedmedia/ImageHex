require 'rails_helper'

RSpec.describe ListingPolicy do

  let(:creator) { create(:user) }
  let(:user) { create(:user) } 
  subject { described_class }

  context "with an open listing" do
    let(:listing) { create(:open_listing, user: creator) }

    permissions :show? do
      it "works with users" do
        expect(subject).to permit(user, listing)
      end

      it "works with creator" do
        expect(subject).to permit(creator, listing)
      end
    end
  end

  context "with a closed listing" do
    let(:listing) { create(:listing, user: creator) }

    permissions :show? do
      it "does not work with users" do
        expect(subject).to_not permit(user, listing)
      end

      it "works with creator" do
        expect(subject).to permit(creator, listing)
      end
    end
  end
end
