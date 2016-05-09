require 'rails_helper'

RSpec.describe OrderPolicy do

  let(:user) { create(:user) }

  subject { described_class }

  permissions :show? do
    it "works with the order's listing" do
      listing = create(:listing,
                       user: user)
      order = create(:order,
                     listing: listing)
      expect(subject).to permit(user, order)
    end

    it "works with an order's creator" do
      order = create(:order,
                     user: user)
      expect(subject).to permit(user, order)
    end
  end

  permissions :create? do
  end

  permissions :update? do
  end

  permissions :destroy? do
  end
end
