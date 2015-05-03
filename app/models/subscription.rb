##
# Join table: User <-> Collection
# Shows what collections a user is subscribed to.
# Not very interesting.
class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection
end
