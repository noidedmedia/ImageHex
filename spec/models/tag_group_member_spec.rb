require 'spec_helper'

describe TagGroupMember do
  it { should validate_presence_of(:tag) }
  it { should validate_presence_of(:tag_group) }
end
