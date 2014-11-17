require 'spec_helper'

describe User do
  # Validations for the name
  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name)}
  it {should validate_length_of(:name).is_at_least(4)}
  # Has many images, no duplicates
  it {should have_many(:images)}
  it {should validate_uniqueness_of(:images)}

end
