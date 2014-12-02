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
      expect(group.tags.map(&:name)).to eq(["falling",
                                            "dying",
                                            "hitting things"])
    end
    it "doesn't make duplicates" do
      image = FactoryGirl.create(:image)
      # we make the tag here
      tag = FactoryGirl.create(:tag, name: "other test")
      group = TagGroup.new
      group.image = image
      # and it shouldn't get made here
      group.tag_group_string = "test, other test"
      group.save
      expect(group.tags).to include(tag)
    end
    it "properly foramts tags" do
      image = FactoryGirl.create(:image)
      group = TagGroup.new
      group.image = image
      group.tag_group_string = "tEst, BLACK"
      group.save
      expect(group.tags.map(&:name)).to eq(["test", "black"])
    end
  end
  describe "#by_tag_names" do
    let(:wanted){FactoryGirl.create(:tag_group)}
    let(:unwanted){FactoryGirl.create(:tag_group)}
    it "gets the correct tag groups" do
      expect(TagGroup.by_tag_names(wanted.tags.map(&:name))).to include(wanted)
    end
    it "doesn't get incorrect tag groups" do
      result = TagGroup.by_tag_names(wanted.tags.map(&:name))
      expect(result).to_not include(unwanted)
    end
  end
end
