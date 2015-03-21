require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end
    describe "get #edit" do
      it "sets the user variable" do
        get :edit, id: @user.id
        expect(assigns(:user)).to eq(@user)
      end
      it "responds with success" do
        get :edit, id: @user.id
        expect(response).to be_success
      end
    end
    describe "put #update" do
      describe "updating user page" do
        it "allows updating" do
          put :update, id: @user.id, user: {page: "test"}
          expect(@user.user_page.body).to eq("test")
        end
      end
      describe "updating avatar" do
        it "allows updating" do
          img = FactoryGirl.create(:image)
          put :update, id: @user.id, user: {avatar_id: @image.id}
          expect(@user.avatar).to eq(img)
        end
      end
    end
  end
end
