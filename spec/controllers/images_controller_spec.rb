require 'spec_helper'

describe ImagesController do
  include Devise::TestHelpers

  describe "GET 'new'" do

    context "when logged in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      it "returns http success" do
        get 'new'
        response.should be_success
      end
    end
    context "when not logged in" do
      it "redirects to the new user page" do
        get 'new'
        expect(response).to redirect_to "/users/sign_up"
      end
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
