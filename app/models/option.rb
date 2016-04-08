class Option < ActiveRecord::Base
  belongs_to :listing, required: true
end
