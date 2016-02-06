require 'spec_helper'

describe ImagesController do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    describe "GET #new" do
      it "responds with an HTTP success" do
        get :new
        expect(response).to be_success
      end
    end
    describe "GET #show" do
      it "shows the iamge" do
        get :show, params: { id: FactoryGirl.create(:image) }
        expect(response).to be_success
      end
    end
    describe "POST #update" do
      it "works when the user has made the image" do
        i = FactoryGirl.create(:image, user: @user, description: "")
        expect(i.description).to eq("")
        post :update,
          params: {
            id: i.id,
            image: { description: "test" }
          }
        expect(i.reload.description).to eq("test")
      end
      it "doesn't work when the user hasn't" do
        u = FactoryGirl.create(:user)
        i = FactoryGirl.create(:image, user: u, description: "")
        expect(i.description).to eq("")
        expect(i.user).to eq(u)
        post :update,
          params: {
            id: i.id,
            image: { description: "test" }
          }
        expect(i.reload.description).to_not eq("test")
        expect(i.reload.description).to eq("")
      end
    end
    describe "POST #create" do
      context "with valid attributes" do
        let(:atrs) { FactoryGirl.attributes_for(:image) }
        it "creates a new image" do
          expect do
            post :create, params: { image: atrs }
          end.to change { Image.count }.by(1)
        end
        it "Redirects to the image" do
          post :create, params: { image: atrs }
          expect(response).to redirect_to(Image.last)
        end
      end
    end
    describe "POST #favorite" do
      let(:i) { FactoryGirl.create(:image) }
      it "makes a new favorite for a user" do
        expect do
          post :favorite, params: { id: i }
        end.to change { @user.favorites.images.count }.by(1)
      end
      it "adds the image to the user's favorite" do
        post :favorite, params: { id: i }
        expect(@user.favorites.images).to include(i)
      end
    end
    describe "POST #created" do
      let(:i) { FactoryGirl.create(:image) }
      it "makes a new creation for a user" do
        expect do
          post :created, params: { id: i }
        end.to change { @user.creations.count }.by(1)
      end
      it "adds the image to the user's creation" do
        post :created, params: { id: i }
        expect(@user.creations).to include(i)
      end
    end
  end

  context "when not logged in" do
    describe "GET #new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to "/accounts/sign_in"
      end
    end
    describe "GET #show" do
      it "redirects to the login page" do
        get :show, params: { id: FactoryGirl.create(:image) }
        expect(response).to be_success
      end
    end

    describe "POST 'new'" do
      it "doesn't do anything" do
        @images = FactoryGirl.create(:image)
        expect do
          post :new,
            params: {
              id: @image,
              image: FactoryGirl.attributes_for(:image)
            }
        end.to_not change { Image.count }
      end
    end
  end
end
