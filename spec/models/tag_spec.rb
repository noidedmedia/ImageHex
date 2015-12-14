require 'spec_helper'

describe Tag do
  describe "creation" do
    it "requires unique names" do
      t = FactoryGirl.create(:tag, name: "test")
      expect{
        FactoryGirl.create(:tag, name: "test")
      }.to raise_error ActiveRecord::RecordInvalid
    end
    it "is case insensitive with name uniqueness" do
      t = FactoryGirl.create(:tag, name: "test")
      expect{
        FactoryGirl.create(:tag, name: "TEST")
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe "name conversion" do
    it "fixes double-spacing" do
      tag = FactoryGirl.create(:tag, name: "two  spaces")
      expect(tag.name).to eq("two spaces")
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
  it{should have_many(:tag_groups).through(:tag_group_members)}
  it{should have_many(:tag_group_members)}
end
