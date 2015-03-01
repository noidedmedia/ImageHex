require 'spec_helper'

describe TagGroup do
  it{should validate_presence_of(:image)}
  it{should belong_to(:image)}
  it{should have_many(:tag_group_members)}
  it{should have_many(:tags).through(:tag_group_members)}
  describe "The tag group string" do
    it "is filled on load" do
      group = FactoryGirl.create(:tag_group)
      str = group.tags.map(&:name).join(", ")
      new = TagGroup.find(group.id)
      expect(new.tag_group_string).to eq(str)
    end
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
      # Gotta clear up tags with bad names to do this
      group.save
      expect(group.tags.map(&:name)).to eq(["test", "black"])
      expect(group.tags.map(&:display_name)).to eq(["tEst", "BLACK"])
    end
  end
end
