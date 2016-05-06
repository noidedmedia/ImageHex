# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  pending do
    include Devise::TestHelpers
    context "when logged in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @user.confirm
        @user.update(
          stripe_publishable_key: "this_is_fake",
          stripe_user_id: "this_is_also_fake",
          stripe_access_token: "wow_its_fake"
        )
        sign_in @user
      end
      describe "POST #create" do
        let(:listing_params) do
          FactoryGirl.attributes_for(:listing)
        end
        it "creates a new commission offer" do
          expect do
            post :create,
              listing: listing_params
          end.to change { @user.listings.count }.by(1)
        end
      end
    end
  end
end
