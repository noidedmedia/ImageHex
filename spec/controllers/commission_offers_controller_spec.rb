require 'rails_helper'

RSpec.describe CommissionOffersController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    describe "POST #create" do
      before(:each) do
        @product = FactoryGirl.create(:commission_product)
      end
      context "with valid attributes" do
        let(:commission_offer_params) do
          {
            commission_product_id: @product.id,
            description: "test",
            subjects_attributes: [
              {
                description: "test",
                references_attributes: [
                  FactoryGirl.attributes_for(:subject_reference),
                  FactoryGirl.attributes_for(:subject_reference)
                ]
              }
            ]
          }
        end
        it "makes a new offer" do
          expect do
            post :create,
              commission_product_id: @product,
              commission_offer: commission_offer_params
          end.to change { @product.offers.count }.by(1)
          offer = @product.offers.last
          expect(offer.user).to eq(@user)
          expect(offer.subjects.count).to eq(1)
          expect(offer.subjects.first.references.count).to eq(2)
          expect(offer.subjects.first.description).to eq("test")
        end
      end
    end
  end
end
