require 'rails_helper'

RSpec.describe CuratorshipsController, type: :controller do
  include Devise::TestHelpers
  describe "put #update" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end
    let(:collection){FactoryGirl.create(:collection)}
    let(:other_user){FactoryGirl.create(:user)}
    it "works as an admin" do
      c = FactoryGirl.create(:curatorship,
                             user: other_user,
                             collection: collection,
                             level: :mod)
      FactoryGirl.create(:curatorship,
                         user: @user,
                         collection: collection,
                         level: :admin)
      put :update, id: c.id, curatorship: {level: :admin}
      expect(response).to be_success
      expect(c.reload.level).to eq(:admin)
    end
  end
end
