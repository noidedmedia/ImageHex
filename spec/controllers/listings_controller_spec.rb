require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = create(:user)
      @user.confirm
      sign_in @user
    end
    describe "#post create" do
      it "makes a new listing" do
        expect {
          post :create, listing: attributes_for(:listing)
        }.to change{@user.listings.count}.by(1)
      end
    end
  end
end
