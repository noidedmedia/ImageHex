require 'rails_helper'

RSpec.describe CollectionsController, :type => :controller do
  describe "get #index" do
    it "shows all a users collections"
  end
  context "as the right user" do
    describe "get #new" do
      it "sets a @user variable"
      it "renders a new collection form"
    end
    describe "post #create" do
      context "with valid attributes" do
        it "makes a new collection"
        it "redirects to the collection"
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
  context "as wrong user" do
    describe "get #new" do
      it "redirects to the proper new page"
    end
    describe "post #create" do
      it "redirects to the proper new page"
    end
    describe "get #edit" do
      it "redirects to an error page"
    end
    describe "put #update" do
      it "redirects to an error page"
    end
  end
  ##
  # I would test not logged in, but it's a filter and I'm lazy
  # So we're going to ignore it for a bit
end
