# All factories must be valid
#

# Iterate through factory names
FactoryGirl.factories.map(&:name).each do |fname|
  RSpec.describe "The #{fname} factory" do
    it "is valid" do
      puts FactoryGirl.create(fname).errors.full_messages.inspect
      puts "\n\n\n\n\n"
      expect(FactoryGirl.build(fname)).to be_valid
    end
  end
end

