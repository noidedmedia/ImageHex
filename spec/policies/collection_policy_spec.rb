# frozen_string_literal: true
require 'rails_helper'

describe CollectionPolicy do
  let(:user) { User.new }

  subject { described_class }

  let(:collection) { FactoryGirl.create(:collection) }
  let(:user) { FactoryGirl.create(:user) }
  permissions :update? do
    it "allows admins" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :admin)
      expect(subject).to permit(user, collection)
    end
    it "does not allow mods" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :mod)
      expect(subject).to_not permit(user, collection)
    end

    it "does not allow workers" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :worker)
      expect(subject).to_not permit(user, collection)
    end
  end
  permissions :destroy? do
    it "allows admins" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :admin)
      expect(subject).to permit(user, collection)
    end
    it "does not allow mods" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :mod)
      expect(subject).to_not permit(user, collection)
    end

    it "does not allow normal users" do
      FactoryGirl.create(:curatorship,
                         user: user,
                         collection: collection,
                         level: :worker)
      expect(subject).to_not permit(user, collection)
    end
    it "does not allow favorites" do
      expect(subject).to_not permit(user, user.favorites)
    end
    it "does not allow creations" do
      expect(subject).to_not permit(user, user.creations)
    end
  end
end
