require 'rails_helper'

RSpec.describe Notification, :type => :model do
  it {should validate_presence_of(:user)}
  it {should validate_presence_of(:subject)}
  it {should validate_presence_of(:message)}
end
