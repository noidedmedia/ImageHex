# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  include Devise::TestHelpers
  describe "get #suggest" do
    it "suggests properly" do
      names = %w(boddy billy broke)
      allow(Tag).to receive(:suggest).and_return(names)
      get :suggest, params: { name: "b" }
      expect(JSON.parse(response.body)).to eq(names)
    end
  end
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    describe "put #edit" do
      let(:tag) { FactoryGirl.create(:tag) }
      it "updates with valid params" do
        put :update,
          params: {
            id: tag,
            tag: { description: "test" }
          }
        expect(tag.reload.description).to eq("test")
      end
      it "makes a new tracker" do
        expect do
          put :update,
            params: {
              id: tag,
              tag: { description: "test" }
            }
        end.to change { TagChange.count }.by(1)
        expect(TagChange.last.tag.id).to eq(tag.id)
      end
    end
  end
end
