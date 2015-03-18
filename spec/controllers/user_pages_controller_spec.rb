require 'rails_helper'

RSpec.describe UserPagesController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end
    describe "put #update" do
      it "allows the user to update their page" do
        str = "we gucci boys"
        params = FactoryGirl.attributes_for(:user_page, body: str)
        put :update, page: {body: str}
        expect(@user.user_page.reload.body).to eq(str)
      end
    end
    describe "get #edit" do
      it "sets the @page variable" do
        get :edit
        expect(assigns(:page)).to eq(@user.user_page)
      end
    end
  end
end
