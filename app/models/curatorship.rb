##
# A curatorship is a join table between a user who curates a collection and the
# collections they curate
# Although it does not currently, it will eventually implement various
# permissions functionality.
# For now, it's a relatively boring join table. 
class Curatorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection
  enum level: [:viewer, :mod, :admin]
end
