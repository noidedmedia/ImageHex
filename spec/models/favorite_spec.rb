require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "validation" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:user) }
    it "should not allow duplicates" do
      i = create(:image)
      u = create(:user)
      create(:favorite, image: i, user: u)
      expect(build(:favorite, image: i, user: u)).to_not be_valid
    end
  end
end
