require 'rails_helper'

RSpec.describe CuratorshipsController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
    let(:collection) { FactoryGirl.create(:collection) }
    let(:other_user) { FactoryGirl.create(:user) }
    describe "put #update" do
      it "works as an admin" do
        c = FactoryGirl.create(:curatorship,
                               user: other_user,
                               collection: collection,
                               level: :mod)
        FactoryGirl.create(:curatorship,
                           user: @user,
                           collection: collection,
                           level: :admin)
        put(:update,
            id: c.id,
            collection_id: collection.id,
            curatorship: FactoryGirl.attributes_for(:curatorship,
                                                    user_id: other_user.id,
                                                    level: :admin))
        expect(c.reload.level).to eq("admin")
      end
    end
    describe "post #create" do
      it "works as an admin" do
        c = FactoryGirl.create(:curatorship,
                               user: @user,
                               collection: collection,
                               level: :admin)
        post(:create,
             collection_id: collection.id,
             curatorship: FactoryGirl.attributes_for(:curatorship,
                                                     user_id: other_user.id,
                                                     level: :mod))
        expect(Curatorship.last.user).to eq(other_user)
      end
    end
  end
end
