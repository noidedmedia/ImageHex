# frozen_string_lsteral: true
require 'spec_helper'

describe ImagePolicy do
  subject { described_class }
  permissions :created? do
    it "depends on the field in the DB" do
      i = FactoryGirl.create(:image,
                             allow_new_creators: false)
      u = FactoryGirl.create(:user)
      expect(subject).to_not permit(u, i)
      i[:allow_new_creators] = true
      expect(subject).to permit(u, i)
    end
  end
  permissions :destroy? do
    it "allows admins" do
      i = FactoryGirl.create(:image)
      u = FactoryGirl.create(:user, role: :admin)
      expect(subject).to permit(u, i)
    end
    it "allows if created recently and owned" do
      u = FactoryGirl.create(:user)
      i = FactoryGirl.create(:image,
                             created_at: 10.minutes.ago,
                             user: u)
      expect(subject).to permit(u, i)
    end
    it "does not allow old images" do
      u = FactoryGirl.create(:user)
      i = FactoryGirl.create(:image,
                             created_at: 3.weeks.ago,
                             user: u)
      expect(subject).to_not permit(u, i)
    end
  end
end
