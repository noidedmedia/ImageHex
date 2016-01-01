class Conversation < ActiveRecord::Base
  belongs_to :commission_offer,
    required: false
end
