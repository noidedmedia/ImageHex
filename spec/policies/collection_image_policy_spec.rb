require 'spec_helper'

describe CollectionImagePolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:collection) {FactoryGirl.create(:collection)}
  let(:image){FactoryGirl.create(:image)}
  let(:i){FactoryGirl.create(:collection_image,
                             user: user,
                             image: image,
                             collection: collection)}
  subject { CollectionImagePolicy }



  permissions :create? do
    it "allows users who are curators" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection)
      expect(subject).to permit(user, i)
    end
  end

  permissions :destroy? do
    it "allows mods" do
     c =  FactoryGirl.create(:curatorship,
                             user: user,
                             collection: collection,
                             level: :mod)
     expect(subject).to permit(user, i)
    end
    it "allows admins" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :admin)
      expect(subject).to permit(user, i)
    end
    it "does not allow normal users" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :worker)
      expect(subject).to_not permit(user, i)
    end
  end
end
