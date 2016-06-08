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

    describe "POST #accept" do 
      context "with priced listings" do
        let(:listing) { create(:listing, user: @user) }
        let(:order) do
          create(:order,
                 listing: listing,
                 confirmed: true)
        end

        it "allows the user to accept the order" do
          expect do
            post :accept,
              listing_id: listing.id,
              id: order.id
          end.to change{order.reload.accepted}.from(false).to(true)
        end
      end
      context "with quote listings" do
        let(:listing) { create(:quote_listing, user: @user) }
        let(:order) do
          create(:order,
                 listing: listing,
                 confirmed: true)
        end

        it "allows the user to give a price" do
          expect do
            post :accept,
              listing_id: listing.id,
              id: order.id,
              quote_price: 500
          end.to change{order.reload.final_price}.to(500)
        end

        it "gives the user a notification" do 
          expect do
            post :accept,
              listing_id: listing.id,
              id: order.id,
              quote_price: 500
          end.to change{Notification.count}.by(1)
        end
      end
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
      
      it "gives the artist a notification" do
        expect do
          post :confirm,
            listing_id: listing.id,
            id: order.id
        end.to change{Notification.count}.by(1)
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

        let(:references_attributes) do
          {listing_category_id: listing.categories.sample.id,
            description: "This is a test"}
            .merge(images_attributes: [images_attributes])
        end

        let(:order_option_ids) do
          # obtain a randomly sized sample
          listing.options.sample(1 + rand(listing.options.count)).map(&:id)
        end

        let(:order_params) do
          attributes_for(:order)
            .merge(option_ids: order_option_ids)
            .merge(references_attributes: [references_attributes])
        end

        it "creates a new order" do
          p = order_params
          expect do
            post(:create,
              listing_id: listing.id,
              order: p)
          end.to change{Order.count}.by(1)
          expect(Order.last.options.pluck(:id)).to match_array(order_option_ids)
        end
        it "creates a new order on the listing" do
          p = order_params
          expect do
            post(:create,
                 listing_id: listing.id,
                 order: p)
          end.to change{listing.orders.count}.by(1)
        end
      end
    end
  end
end
