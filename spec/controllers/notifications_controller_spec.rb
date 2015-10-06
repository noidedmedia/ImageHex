require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    describe "post #mark_all_read" do
      it "marks all as read" do
        n1 = FactoryGirl.create(:notification, user: @user)
        n2 = FactoryGirl.create(:notification, user: @user)
        post :mark_all_read
        expect(n1.reload.read).to eq(true)
        expect(n2.reload.read).to eq(true)
      end
    end
    describe "get #index" do
      it "gives the users notifications" do
        n = FactoryGirl.create(:notification, user: @user)
        get :index
        expect(assigns(:notifications)).to eq(@user.notifications)
      end
    end
    describe "get #unread" do
      it "responds with unread notifications" do
        notification = FactoryGirl.create(:notification, user: @user)
        get :unread
        expect(assigns(:notifications)).to eq([notification])
      end
    end
    describe "post #read" do
      it "marks a notification as read" do
        n = FactoryGirl.create(:notification, user: @user)
        expect(n.read).to eq(false)
        post :read, id: n.id
        n.reload
        expect(n.read).to eq(true)
      end
    end
  end
end
