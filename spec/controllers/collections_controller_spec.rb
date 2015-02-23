require 'rails_helper'

RSpec.describe CollectionsController, :type => :controller do
  include Devise::TestHelpers
  describe "get #index" do
    it "shows all a users collections" do
      user = FactoryGirl.create(:user)
      user.collections = [FactoryGirl.create(:collection),
                          FactoryGirl.create(:collection)]
      get :index, user_id: user
      expect(assigns(:collections)).to match_array(user.collections)
    end
    it "renders the index page" do
      user = FactoryGirl.create(:user)
      user.collections << [FactoryGirl.create(:collection)]
      get :index, user_id: user
      expect(response).to render_template("index")
    end
  end
  describe "get #show" do
    let(:c){FactoryGirl.create(:collection)}
    it "is success" do
      get :show, id: c.id
      expect(response).to be_success
    end
    it "sets the images variable" do
      get :show, id: c.id
      expect(assigns(:images)).to eq(c.images)
    end
    it "sets the collection variable" do
      get :show, id: c.id
      expect(assigns(:collection)).to eq(c)
    end
    it "sets the curators variable" do
      get :show, id: c.id
      expect(assigns(:curators)).to eq(c.curators)
    end
  end
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end

    describe "post #subscribe" do
      let(:c){FactoryGirl.create(:collection)}
      it "adds the collection to a users subscribed collections" do
        expect{
          post "subscribe", id: c
        }.to change{@user.subscribed_collections.count}.by(1)

      end
    end
    describe "get #new" do
      it "sets a @collection variable"
      it "renders a new collection form"
    end
    describe "post #create" do
      context "with valid attributes" do
        let(:subjective_atrs){ {type: "Subjective",
                                name: "My Kawaii Images"}}
        it "makes a new collection of the proper type" do
          expect{
            post :create, collection: subjective_atrs
          }.to change{Subjective.count}.by(1)
        end
        it "redirects to the collection" do
          post :create, collection: subjective_atrs
          expect(response).to redirect_to(collection_path(Collection.last))
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
