require 'spec_helper'

describe Admin::ImagesController do
  include Devise::TestHelpers
  context "as admin" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: :admin)
      @user.confirm
      sign_in @user
    end
    describe "get #index" do
      it "creates a list of reported images" do
        reported = FactoryGirl.create(:image)
        FactoryGirl.create(:image_report, image: reported)
        not_reported = FactoryGirl.create(:image)
        get :index
        expect(assigns(:images)).to eq([reported])
      end
      it "is successful" do
        get :index
        expect(response).to be_success
      end
    end
    describe "post #absolve" do
      it "removes all reports on the image" do
        image = FactoryGirl.create(:image)
        FactoryGirl.create(:image_report, image: image)
        expect do
          post :absolve, params: { id: image }
        end.to change { image.image_reports.active.count }.from(1).to(0)
      end
    end
    describe "post #destroy" do
      it "removes the image" do
        img = FactoryGirl.create(:image)
        expect do
          post :destroy, params: { id: img }
        end.to change { Image.count }.by(-1)
      end
    end
  end
end
