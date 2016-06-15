require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = create(:user)
      @user.confirm
      sign_in @user
    end

    let(:category_attributes) { attributes_for(:listing_category) }

    let(:option_attributes) { attributes_for(:listing_option) }

    let(:listing_attributes) do
      attributes_for(:listing)
        .merge(categories_attributes: [category_attributes])
        .merge(options_attributes: [option_attributes])
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
