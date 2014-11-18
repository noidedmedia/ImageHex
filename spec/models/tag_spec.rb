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

end
