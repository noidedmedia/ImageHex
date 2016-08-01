require 'rails_helper'

RSpec.describe FavoritePolicy do

  let(:user) { create(:user) }

  subject { described_class }

  

  permissions :create? do
  end



  permissions :destroy? do
    let(:user2) { create(:user) }
    let(:favorite) { create(:favorite, user: user) }
    it "should not allow other users" do
      expect(subject).to_not permit(user2, favorite)
    end
    it "should allow the same user" do
      expect(subject).to permit(user, favorite)
    end
  end
end
