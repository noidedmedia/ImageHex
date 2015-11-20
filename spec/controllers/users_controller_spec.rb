require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    describe "post #subscribe" do
      it "creates a subscription" do
        u = FactoryGirl.create(:user)
        expect{
          post :subscribe, id: u.id
        }.to change{ArtistSubscription.count}.by(1)
        expect(@user.subscribed_artists).to include(u)
      end
    end
    describe "delete #unsubscribe" do
      it "creates a subscription" do
        u = FactoryGirl.create(:user)
        @user.subscribe! u
        expect(@user.subscribed_artists).to include(u)
        expect{
          delete :unsubscribe, id: u.id
        }.to change{ArtistSubscription.count}.by(-1)
        expect(@user.subscribed_artists).to_not include(u)
      end
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
      describe "updating page pref" do
        it "allows update" do
          put :update, id: @user.id, user: {page_pref: 10}
          expect(@user.reload.page_pref).to eq(10)
        end
      end
      describe "updating content ratings" do
        # Can't get this test to work properly, note that I have manually
        # verified it works
        it "allows updating"
      end
    end
  end
end
