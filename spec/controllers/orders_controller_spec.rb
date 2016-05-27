require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include Devise::TestHelpers
  let(:listing) { create(:listing) }
  context "when logged in" do
    before(:each) do
      @user = create(:user)
      @user.confirm
      sign_in @user
    end

    describe "POST #confirm" do
      let(:order) { create(:order,
                           listing: listing,
                           user: @user) }
      it "confirms the order" do
        expect do
          post :confirm,
            listing_id: listing.id,
            id: order.id
        end.to change{order.reload.confirmed}.from(false).to(true)
      end
    end

    describe "GET new" do
      it "returns success" do
        get :new, listing_id: listing.id
        expect(response).to be_success
      end
    end

    describe "POST create" do
      context "with valid attributes" do

        let(:images_attributes) do
          attributes_for(:order_reference_image)
        end

        let(:reference_attributes) do
          {listing_category_id: listing.categories.sample.id,
            description: "This is a test"}
            .merge(images_attributes: [images_attributes])
        end

        let(:option_attributes) do
          {listing_option_id: listing.options.sample.id}
        end

        let(:order_params) do
          attributes_for(:order)
            .merge(option_attributes: [option_attributes])
            .merge(reference_attributes: [reference_attributes])
        end

        it "creates a new order" do
          expect do
            post(:create,
              listing_id: listing.id,
              order: order_params)
          end.to change{listing.reload.orders.count}.by(1)
        end
      end
    end
  end
end
