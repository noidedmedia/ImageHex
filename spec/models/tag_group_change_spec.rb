require 'rails_helper'

RSpec.describe TagGroupChange, type: :model do
  let(:tag_a) { FactoryGirl.create(:tag) }
  let(:tag_b) { FactoryGirl.create(:tag) }
  let(:tag_c) { FactoryGirl.create(:tag) }
  let(:before_tags) { [tag_a, tag_b] }
  let(:after_tags) { [tag_b, tag_c] }
  let(:group) { FactoryGirl.create(:tag_group) }
  let(:change) do
    FactoryGirl.create(:tag_group_change,
                       tag_group: group,
                       before: before_tags.map(&:id),
                       after: after_tags.map(&:id))
  end
  it "resolves the before tags properly" do
    expect(change.before).to match_array(before_tags.map(&:id))
    expect(change.before_tags).to match_array(before_tags)
  end

  it "resolves the after tags properly" do
    expect(change.after).to match_array(after_tags.map(&:id))
    expect(change.after_tags).to match_array(after_tags)
  end

  it "resolves the added tags properly" do
    expect(change.added_tags).to eq([tag_c])
  end

  it "resolves the removed tags" do
    expect(change.removed_tags).to eq([tag_a])
  end

  it "resoleves the unchanged tags" do
    expect(change.unchanged_tags).to eq([tag_b])
  end

  describe ".revert!" do
    it "reverts all changes" do
      change.revert!
      expect(group.reload.tags).to eq(before_tags)
    end
  end
end
