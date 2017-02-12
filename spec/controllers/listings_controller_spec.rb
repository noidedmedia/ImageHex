require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  include Devise::Test::ControllerHelpers
  context "when logged in" do
    before(:each) do
      @user = create(:user)
      @user.confirm
      sign_in @user
    end

    let(:listing_attributes) do
      attributes_for(:listing)
    end

    describe "#post create" do
      it "makes a new listing" do
        expect do
          post :create, params: {
            listing: listing_attributes
          }
        end.to change{@user.listings.count}.by(1)
      end
    end
  end
end
