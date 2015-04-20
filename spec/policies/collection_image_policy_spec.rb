require 'spec_helper'

describe CollectionImagePolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:collection) {FactoryGirl.create(:collection)}
  subject { CollectionImagePolicy }

  

  permissions :create? do
    it "allows users who are curators" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection)
      expect(subject).to permit(user, collection)
    end
  end

  permissions :delete? do
    it "allows mods" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :mod)
      expect(subject).to permit(user, collection)
    end
    it "allows admins" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :admin)
      expect(subject).to permit(user, collection)
    end
    it "does not allow normal users" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :worker)
      expect(subject).to_not permit(user, collection)
    end
  end
end
