require 'spec_helper'

describe Tag do
  describe "name conversion" do
    it "fixes double-spacing" do
      tag = FactoryGirl.create(:tag, name: "two  spaces")
      expect(tag.name).to eq("two spaces")
    end
    it "removes capitals" do
      str = "Afas KLAJS asd"
      tag = FactoryGirl.create(:tag, name: str)
      expect(tag.name).to eq(str.downcase)
    end
    it "removes trailing whitespace" do
      str = "asd  "
      tag = FactoryGirl.create(:tag, name: str)
      expect(tag.name).to eq(str.strip)
    end
  end
  describe "suggesting" do
    it "suggets properly" do
      FactoryGirl.create(:tag, name: "bob")
      FactoryGirl.create(:tag, name: "billy")
      FactoryGirl.create(:tag, name: "asdf")
      expect(Tag.suggest("b").map(&:name)).to contain_exactly("bob", "billy")
      expect(Tag.suggest("b").map(&:name)).to_not include("asdf")
    end
  end
  describe "display names" do
    it "must change in case only" do
      t = FactoryGirl.create(:tag, name: "yo")
      t.display_name = "This is not right"
      expect(t).to_not be_valid
    end
    it "allows changes in case" do
      t = FactoryGirl.create(:tag, name: "yo")
      t.display_name = "YO"
      expect(t).to be_valid
    end
  end
  it{should have_many(:tag_groups).through(:tag_group_members)}
  it{should have_many(:tag_group_members)}
end
