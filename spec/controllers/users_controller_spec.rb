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
      it "redirects if your user is wrong" do
        get :edit, id: FactoryGirl.create(:user).id
        expect(response).to redirect_to(edit_user_path(@user))
      end
    end
    describe "put #update" do
      describe "updating user page" do
        it "allows updating" do
          put :update, id: @user.id, user: {page_body: "test"}
          expect(@user.reload.user_page.body).to eq("test")
        end
      end
      describe "updating avatar" do
        it "allows updating" do
          puts @user.inspect
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
