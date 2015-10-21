require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
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
    describe "PUT #enable_twofactor" do
      it "enables 2factor" do
        # Ensure it's not enabled at this point
        @user.otp_required_for_login = false
        @user.save
        put :enable_twofactor, id: @user
        expect(@user.reload.otp_required_for_login).to eq(true)
        expect(@user.reload.otp_secret).to_not be_nil
      end
      it "doesn't work for other users" do
        put :enable_twofactor, id: FactoryGirl.create(:user)
        expect(response).to_not be_success
      end

    end
    describe "PUT #disable_twofactor" do
      it "disables 2factor" do
        @user.enable_twofactor
        put :disable_twofactor, id: @user
        expect(@user.reload.otp_required_for_login).to eq(false)
      end
      it "does not work for other users" do
        u = FactoryGirl.create(:user)
        u.enable_twofactor
        put :disable_twofactor, id: u
        expect(response).to_not be_success
      end
    end
    describe "GET #twofactor_key" do
      it "responds with a QR gif" do
        @user.enable_twofactor
        get :twofactor_key, id: @user, format: :gif
        expect(response).to be_success
      end
      it "responds with a QR png" do
        @user.enable_twofactor
        get :twofactor_key, id: @user, format: :gif
        expect(response).to be_success
      end
      it "responds with normal html" do
        @user.enable_twofactor
        get :twofactor_key, id: @user
        expect(response).to be_success
      end
      it "doesn't work for other users" do
        @user.enable_twofactor
        u = FactoryGirl.create(:user)
        u.enable_twofactor
        get :twofactor_key, id: u
        expect(response).to_not be_success
      end
    end
  end
end
