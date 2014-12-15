require 'spec_helper'

describe CollectionsController do
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      log_in(@user)
    end
    context "with subjective collections" do
      let(:subjective_kind){Collection.kinds["subjective"]}
      let(:c){
        FactoryGirl.create(:collection, kind: chrono_kind, user: @user)
      }
      describe "get #edit" do
        it "renders the proper template" do
          get :edit, id: c
          expect(response).to render_template("edit_subjective")
        end
        it "responds with success" do
          get :edit, id: c
          expect(response).to be_success
        end
      end
      describe "get #new" do
        it "renders the right template"
        it "responds with success"
      end
    end
    context "with chrono collections" do
      let(:chrono_kind){Collection.kinds["chrono"]}
      let(:c){
        FactoryGirl.create(:collection, kind: chrono_kind, user: @user)
      }
      describe "get #edit" do
        it "renders the proper edit template" do
          get :edit, id: c
          expect(response).to render_template("edit_chrono")
        end
        it "responds with success" do
          get :edit, id: c
          expect(response).to be_success
        end
      end
      describe "get #new" do
        it "renders the proper template"
        it "responds with success"
      end
      describe "post #create" do
        context "with valid attributes" do
          it "makes a new collection"
        end
        context "with invalid attributes" do
          it "doesn't make a new collection"
        end
      end
      describe "put #update" do
        context "with valid attributes" do
          it "changes the collection"
          it "redirects to the newly changed collection"
        end
        context "with invalid attributes" do
          it "does not change the collection"
          it "renders the edit template with errors"
        end
      end
    end

    context "with favorites collections" do 
      describe "get #edit" do
        # users cannot edit anything on their favorites template
        it "doesn't allow editing" do
          get :edit, id: @user.favorites_collection
          expect(response).to render_template("uneditable")
        end
      end
    end


    context "with creations collection" do
      let(:creations_kind){Collection.kinds["creations"]}
      let(:c){@user.creations_collection}
      describe "get #edit" do
        it "renders the right template" do
          get :edit, id: @user.creations_collection
          expect(response).to render_template("creation_edit")
        end
      end
      describe "get #new" do
        it "doesn't make a new collection"
        it "renders the right template"
      end
      describe "post #create" do
        it "redirects to the error page"
      end
    end
  end
end 
