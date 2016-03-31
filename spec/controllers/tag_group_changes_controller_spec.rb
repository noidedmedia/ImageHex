# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TagGroupChangesController, type: :controller do
  let(:image) { FactoryGirl.create(:image) }
  let(:group) do
    FactoryGirl.create(:tag_group,
                       image: image)
  end
  let(:change) do
    FactoryGirl.create(:tag_group_change,
                       tag_group: group)
  end
  describe "get #index" do
    it "displays all tag groups" do
      get :index, tag_group_id: group.id, image_id: image.id
      expect(assigns(:changes)).to eq([change])
    end
    it "is successful" do
      get :index, tag_group_id: group.id, image_id: image.id
      expect(response).to be_success
    end
  end
end
