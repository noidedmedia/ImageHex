require 'spec_helper'

describe TagGroupsController do
  include Devise::TestHelpers
  context "when logged in" do
    let(:image){FactoryGirl.create(:image)}
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    describe "post #create" do
      it "makes a new tag group" do
        expect{post :create, image_id: image, tag_group: {tag_group_string: "test, another, more"}}
          .to change{TagGroup.count}.by(1)

      end
    end
    describe 'get #new' do
      it "responds successfully" do
        get :new, image_id: image
        expect(response).to be_success
      end
    end
    describe "get #edit" do
      let(:group){FactoryGirl.create(:tag_group)}
      it "responds successfully" do
        get :edit, image_id: group.image, id: group
        expect(response).to be_success
      end
      it "sets the variables correctly" do
        get :edit, image_id: group.image, id: group
        expect(assigns(:tag_group)).to eq(group)
      end
    end
  end
  context "when not logged in" do
    let(:image){FactoryGirl.create(:image)}
    describe "get #new" do
      it "redirects to the login page" do
        get :new, image_id: image
        expect(response).to redirect_to("/users/sign_in")
      end
    end
    describe "get #edit" do
      it "redirects to the login page" do
        get :new, image_id: image
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end
end
