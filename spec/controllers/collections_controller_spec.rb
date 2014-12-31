require 'rails_helper'

RSpec.describe CollectionsController, :type => :controller do
  include Devise::TestHelpers
  describe "get #index" do
    it "shows all a users collections" do
      user = FactoryGirl.create(:user)
      user.collections = [FactoryGirl.create(:collection), 
                          FactoryGirl.create(:collection)]
      get :index, user_id: user
      expect(assigns(:collections)).to eq(u.collections)
    end
    it "renders the index page" do

    end
  end
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end
    describe "get #new" do
      it "sets a @collection variable"
      it "renders a new collection form"
    end
    describe "post #create" do
      context "with valid attributes" do
        let(:subjective_atrs){ {type: "Subjective",
                                name: "My Kawaii Images"} }
        let(:chrono_atrs){ {type: "Chronological",
                            name: "Comic: Zach Attack!"} }

        it "makes a new collection of the proper type" do
          expect{
            post :create, collection: subjective_atrs
          }.to change{Subjective.count}.by(1)
          expect{
            post :create, collection: chrono_atrs
          }.to change{Chronological.count}.by(1)
        end
        it "redirects to the collection" do
          post :create, collection: FactoryGirl.attributes_for(:subjective)
          expect(response).to redirect_to(Subjective.last)
        end
      end
      context "with invalid attributes" do
        it "doesn't make a new collection"
        it "renders the #new page with errors set"
      end 
    end
    describe "get #edit" do
      it "doesn't update the title of innate collections"
      it "renders the edit form"
    end
    describe "put #update" do
      context "with valid attributes" do
        it "updates the collection"
        it "redirects to the collection page"
      end
      context "with invalid attributes" do
        it "does not modify the collection"
        it "renders the #edit page with errors set"
      end
    end
  end
end
