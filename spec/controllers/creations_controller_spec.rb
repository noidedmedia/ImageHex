require 'rails_helper'

RSpec.describe CreationsController, :type => :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.created! FactoryGirl.create(:image)
  end
  describe "get #index" do
    it "populates a list of images with the images" do
      get :index, user_id: @user
      expect(assigns(:images)).to eq(@user.creations.images)
    end
    it "renders the right template" do
      get :index, user_id: @user
      expect(response).to render_template("creations/index")
    end
  end
end
