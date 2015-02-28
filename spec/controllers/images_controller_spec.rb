require 'spec_helper'

describe ImagesController do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
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
        get :show, id: FactoryGirl.create(:image)
        expect(response).to be_success
      end
    end
    describe "POST #create" do
      context "with valid attributes" do
        let(:atrs){FactoryGirl.attributes_for(:image)}
        it "creates a new image" do
          expect{
            post :create, image: atrs
          }.to change{Image.count}.by(1)
        end
        it "Redirects to the image" do
          post :create, image: atrs
          expect(response).to redirect_to(Image.last)
        end
      end
    end
    describe "POST #favorite" do
      let(:i){FactoryGirl.create(:image)}
      it "makes a new favorite for a user" do
        expect{post :favorite, id: i}.to change{@user.favorites.images.count}.by(1)
      end
      it "adds the image to the user's favorite" do
        post :favorite, id: i
        expect(@user.favorites.images).to include(i)
      end
    end
    describe "POST #created" do
      let(:i){FactoryGirl.create(:image)}
      it "makes a new creation for a user" do
        expect{
          post :created, id: i
        }.to change{@user.creations.images.count}.by(1)
      end
      it "adds the image to the user's creation" do
        post :created, id: i
        expect(@user.creations.images).to include(i)
      end
    end
   
  end

  context "when not logged in" do
    describe "GET #new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to "/sessions/sign_in"
      end
    end
    describe "GET #show" do
      it "redirects to the login page" do
        get :show, id: FactoryGirl.create(:image)
        expect(response).to be_success
      end
    end
    describe "POST #edit" do
    end
    describe "POST 'new'" do
      it "doesn't do anything" do
        @images = FactoryGirl.create(:image)
        expect{
          post :new, id: @image, image: FactoryGirl.attributes_for(:image)
        }.to_not change{Image.count}
      end
    end

  end
end
