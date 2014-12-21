require 'spec_helper'

describe Collections::FavoritesController do
  describe "get #new" do
    it "doesn't work" do
      get "collections/favorites/new"
      expect(response.status).to eq(404)
    end
  end
  describe "post #create" do
    it "doesn't work"
    # We don't actually care what data, since it needs to 404
    post "collections/favorites/create", c: {test: "test"}
    expect(response.status).to eq(404)
  end
end
