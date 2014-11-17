require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  # Validations for the name
  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name).case_insensitive}
  # Has many images
  it {should have_many(:images)}

end
