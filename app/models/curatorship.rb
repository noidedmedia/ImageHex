##
# A curatorship is a join table between a user who curates a collection and the collection they curate.
# Although it does not currently, it will eventually implement various
# permissions functionality.
class Curatorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection
end
