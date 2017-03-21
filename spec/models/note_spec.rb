require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "validation" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
