##
# A curatorship is a join table between a user who curates a collection and the
# collections they curate.
# It also includes a level of curatorship for permissions purposes.
class Curatorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection

  enum level: [:worker, :mod, :admin]
end
