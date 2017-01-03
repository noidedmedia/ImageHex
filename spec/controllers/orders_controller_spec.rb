require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include Devise::TestHelpers
  let(:listing) { create(:open_listing) }
  context "when logged in" do
    before(:each) do
      @user = create(:user)
      @user.confirm
      sign_in @user
    end

    describe "POST #accept" do 
      context "with quote listings" do
        let(:listing) { create(:listing, user: @user) }
        let(:order) do
          create(:order,
                 listing: listing,
                 confirmed: true)
              
        end

        it "allows the user to give a price" do
          expect do
            post :accept,
              params: {
              listing_id: listing.id,
              id: order.id,
              quote_price: 500
            }
          end.to change{order.reload.final_price}.to(500)
        end

        it "gives the user a notification" do 
          expect do
            post :accept,
              params: {
              listing_id: listing.id,
              id: order.id,
              quote_price: 500
            }
          end.to change{Notification.count}.by(1)
        end

        it "updates #accepted_at" do
          expect do
            post :accept,
              params: {
              listing_id: listing.id,
              id: order.id,
              quote_price: 500
            }
          end.to change{order.reload.accepted_at}
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
            params: {
            listing_id: listing.id,
            id: order.id
          }
        end.to change{order.reload.confirmed}.from(false).to(true)
      end
      
      it "gives the artist a notification" do
        expect do
          post :confirm,
            params: {
              listing_id: listing.id,
              id: order.id
            }
        end.to change{Notification.count}.by(1)
      end

      it "changes confirmed_at" do
        expect do
          post :confirm,
            params: {
            listing_id: listing.id,
            id: order.id
          }
        end.to change{order.reload.confirmed_at}
      end
    end

    describe "GET new" do
      it "returns success" do
        get :new, params: {listing_id: listing.id}
        expect(response).to be_success
      end
    end


    describe "POST create" do
      context "with valid attributes" do
        let(:images_attributes) do
          attributes_for(:order_reference_group_image).select do |a|
            [:description, :img].include? a
          end
        end

        let(:reference_group_attributes) do
          {description: "This is a test"}
            .merge(images_attributes: {1 => images_attributes})
        end

        let(:order_params) do
          rga = {1 => reference_group_attributes}
          attributes_for(:order)
            .merge(description: "This is the one you want")
            .merge(reference_groups_attributes: rga)
        end

        it "fixes stuff" do
          order_params # need this because it creates an order for some reason
          p = lambda do
            post(:create,
                 params: {
                    listing_id: listing.id,
                    order: order_params
                })
          end
          expect(p).to change{Order.count}.by(1).and \
            change{listing.orders.count}.by(1)
        end
        #it { should change{Order.count}.by 1}
        #it { should change{listing.orders.count}.by 1}
      end
    end
  end
end
