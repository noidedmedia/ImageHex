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
      expect(Tag.suggest("b")).to eq(["bob", "billy"])
      expect(Tag.suggest("b")).to_not include("asdf")
    end
  end
  describe "display names" do
    it "keeps capitalization" do
      name = "CAPitalizatAtion"
      expect(FactoryGirl.create(:tag, name: name).display_name).to eq(name)
    end
  end
  describe ".alphabetic" do
    it "should select alphabetically" do
      alpha = [FactoryGirl.create(:tag, name: "a"),
               FactoryGirl.create(:tag, name: "b"),
               FactoryGirl.create(:tag, name: "c")]
      expect(Tag.all.alphabetic).to eq(alpha)
      FactoryGirl.create(:tag, name: "aa")
      expect(Tag.all.alphabetic).to eq(Tag.all.sort_by{|x| x.display_name})

    end 
  end
  it{should have_many(:tag_groups).through(:tag_group_members)}
  it{should have_many(:tag_group_members)}
end
