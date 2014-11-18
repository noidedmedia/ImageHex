require 'spec_helper'

describe ImagesController do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    describe "GET #new" do
      it "responds with an HTTP success" do
        get :new
        expect(response).to be_success
      end
    end
    describe "GET #show" do
      it "shows the iamge" do
        get :show, id: FactoryGirl.create(:image)
        expect(response).to be_success
      end
    end
  end

  context "when not logged in" do
    describe "GET #new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end
    describe "GET #show" do
      it "redirects to the login page" do
        get :show, id: FactoryGirl.create(:image)
        expect(response).to be_success
      end
    end
    describe "POST #edit" do
    end
    describe "POST 'new'" do
      it "doesn't do anything" do
        @images = FactoryGirl.create(:image)
        expect{
          post :new, id: @image, image: FactoryGirl.attributes_for(:image)
        }.to_not change{Image.count}
      end
    end

  end
end
