require 'rails_helper'

RSpec.describe UserPage, type: :model do
  it { should validate_presence_of(:user)}
  describe "elsewhere" do
    it "only allows certain keys" do
      p = FactoryGirl.create(:user_page)
      p.elsewhere = {"tumblr" => "tonysinterested"}
      expect(p).to be_valid
      p.elsewhere = {"not an OK key ever" => "kappa"}
      expect(p).to_not be_valid
    end
  end
end
