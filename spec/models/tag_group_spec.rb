require 'spec_helper'

describe TagGroup do
  it{should validate_presence_of(:image)}
  it{should belong_to(:image)}
  it{should have_many(:tag_group_members)}
  it{should have_many(:tags).through(:tag_group_members)}
  describe "The tag group string" do
    it "seperates by commas" do
      image = FactoryGirl.create(:image)
      group = TagGroup.new
      group.image = image
      group.tag_group_string = "falling, dying, hitting things"
      group.save
      expect(group.tags.map(&:name)).to eq(["faling",
                                            "dying",
                                            "hitting things"])
    end
  end
end
