require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "get #suggest" do
    it "suggests properly" do
      names = ["boddy", "billy", "broke"]
      allow(Tag).to receive(:suggest).and_return(names)
      get :suggest, name: "b"
      expect(JSON.parse(response.body)).to eq(names)
    end
  end
end
