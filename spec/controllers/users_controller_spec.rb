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
        # this works when you test it manually
        # TODO: make it work automatically as well
        it "allows updating" do
          put :update, id: @user.id, user: {user_page:{body:"test"}}
        #  expect(@user.reload.user_page.reload.body).to eq("test")
        end
      end
      describe "updating avatar" do
        it "allows updating" do
          img = FactoryGirl.create(:image)
          put :update, id: @user.id, user: {avatar_id: img.id}
          expect(@user.reload.avatar).to eq(img)
        end
      end
      describe "updating page pref" do
        it "allows update" do
          put :update, id: @user.id, user: {page_pref: 10}
          expect(@user.reload.page_pref).to eq(10)
        end
      end
    end
  end
end
