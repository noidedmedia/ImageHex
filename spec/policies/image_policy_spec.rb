require 'spec_helper'

describe ImagePolicy do
  subject {described_class}
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
      expect(subject).to permit(u,i)
    end
    it "does not allow old images" do
      u = FactoryGirl.create(:user)
      i = FactoryGirl.create(:image,
                             created_at: 3.weeks.ago,
                             user: u)
      expect(subject).to_not permit(u,i)
    end
  end
end
      
