require 'spec_helper'

describe TagGroup do
  it{should validate_presence_of(:image)}
  it{should belong_to(:image)}
  it{should have_many(:tag_group_members)}
  it{should have_many(:tags).through(:tag_group_members)}
end
