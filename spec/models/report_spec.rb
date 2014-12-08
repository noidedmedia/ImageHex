require 'spec_helper'

describe Report do
  it{should validate_presence_of :severity}
  it{should validate_length_of(:meesage).is_at_most(500)}
  it{should validate_length_of(:message).is_at_least(50)}

end
