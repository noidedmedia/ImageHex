# All factories must be valid
#

# Iterate through factory names
FactoryGirl.factories.map(&:name).each do |fname|
  RSpec.describe "The #{fname} factory" do
    it "is valid" do
      FactoryGirl.build(fname).should be_valid
    end
  end
end

