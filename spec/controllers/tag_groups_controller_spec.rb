require 'spec_helper'

describe TagGroupsController do
  include Devise::TestHelpers
  context "when logged in" do
    let(:image){FactoryGirl.create(:image)}
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    describe "put #update" do
      let(:group){FactoryGirl.create(:tag_group, image: image)}
      it "properly updates" do
        put(:update,
            image_id: image,
            id: group,
            tag_group: {tag_group_string: "test, another, more"})
        expect(group.reload.tags.pluck(:name)).to contain_exactly("test", "another", "more")
      end
      it "creates a new tag group change" do
        old_tags = group.tags.pluck(:id)
        expect{
          put(:update,
              image_id: image,
              id: group,
              tag_group: {tag_group_string: "test, another"})
        }.to change{TagGroupChange.count}.by(1)
        expect(TagGroupChange.last.tag_group).to eq(group)
        expect(TagGroupChange.last.before).to match_array(old_tags)
      end
    end
    describe "post #create" do
      it "makes a new tag group" do
        expect{post :create, image_id: image, tag_group: {tag_group_string: "test, another, more"}}
          .to change{TagGroup.count}.by(1)

      end
      it "makes a new tag group change" do
        expect{
          post :create, image_id: image, tag_group: {tag_group_string: "test"}
        }.to change{TagGroupChange.count}.by(1)
        expect(TagGroupChange.last.kind).to eq("created")
        expect(TagGroupChange.last.user).to eq(@user)
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
        get :edit, image_id: group.image, id: group.id
        expect(response).to be_success
      end
      it "sets the variables correctly" do
        get :edit, image_id: group.image, id: group.id
        expect(assigns(:tag_group)).to eq(group)
      end
    end
  end
  context "when not logged in" do
    let(:image){FactoryGirl.create(:image)}
    describe "get #new" do
      it "redirects to the login page" do
        get :new, image_id: image
        expect(response).to redirect_to("/accounts/sign_in")
      end
    end
    describe "get #edit" do
      it "redirects to the login page" do
        get :new, image_id: image
        expect(response).to redirect_to("/accounts/sign_in")
      end
    end
  end
end
