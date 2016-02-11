require 'rails_helper'

RSpec.describe DisputePolicy do


  subject { described_class }

  permissions :show? do
    let(:dispute){ create(:dispute) }
    it "allows admins" do
      u = create(:user,
                 role: :admin)
      expect(subject).to permit(u, dispute)
    end
    it "allows the disputer" do
      expect(subject).to permit(dispute.commission_offer.user, dispute)
    end
    it "does not allow random" do
      expect(subject).to_not permit(create(:user), dispute)
    end
  end

  permissions :create? do
    let(:offer){ create(:commission_offer) }
    let(:dispute){ build(:dispute, commission_offer: offer) }
    it "allows the user who made the offer" do
      expect(subject).to permit(offer.user, dispute)
    end

    it "does not allow randoms" do
      expect(subject).to_not permit(create(:user), dispute) 
    end
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
