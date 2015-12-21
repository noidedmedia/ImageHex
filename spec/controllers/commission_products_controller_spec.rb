require 'rails_helper'

RSpec.describe CommissionProductsController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    describe "POST #create" do
      let(:commission_product_params){
        FactoryGirl.attributes_for(:commission_product)
      }
      it "creates a new commission offer" do
        expect{
          post :create,
          commission_product: commission_product_params
        }.to change{@user.commission_products.count}.by(1)
      end
    end
  end
end
