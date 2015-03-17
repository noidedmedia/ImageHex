require 'rails_helper'

RSpec.describe UserPage, type: :model do
  it { should validate_presence_of(:user)}

end
