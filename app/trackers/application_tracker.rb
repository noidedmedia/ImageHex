##
# Shared functionality for all our TrainTrack trackers
class ApplicationTracker
  ##
  # The user that made this change
  attr_reader :user
  ##
  # The record being changed
  attr_reader :record

  ##
  # The initializer is the same for basically every action
  # We exploit that here
  def initialize(user, record)
    @user = user
    @record = record
  end
end

