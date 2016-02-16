# frozen_string_literal: true
require 'spec_helper'

describe TagGroup do
  it { should validate_presence_of(:image) }
  it { should belong_to(:image) }
  it { should have_many(:tag_group_members) }
  it { should have_many(:tags).through(:tag_group_members) }
  describe "tag_ids" do
    let(:tag) { FactoryGirl.create(:tag) }
    it "should set based on the ids" do
      g = FactoryGirl.create(:tag_group)
      g.tag_ids = [tag.id]
      g.save
      expect(g.tags).to contain_exactly(tag)
    end
  end
end
