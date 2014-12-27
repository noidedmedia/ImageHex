require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.favorite! FactoryGirl.create(:image)
  end
  describe "get #index" do
    it "populates a list of the given users favorite images" do
      get :index, user_id: @user
      expect(assigns(:images)).to eq(@user.favorites.images)
    end
    it "renders the favorites/index page" do
      get :index, user_id: @user
      expect(response).to render_template("favorites/index")
    end
  end
end
