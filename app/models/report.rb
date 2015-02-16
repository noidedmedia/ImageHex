##
# A report is a model which is polymorphically related to many other models in ImageHex.
# It is designed to draw something to the attention of moderators so they may remove it if it violates the rules.
# There are three levels of severity, stored as an enum. 
class Report < ActiveRecord::Base
  #############
  # RELATIONS #
  #############
  belongs_to :reportable, polymorphic: true
  belongs_to :user


  #########
  # ENUMS #
  #########
  enum severity: [:illegal, :offensive, :spam]


  ###############
  # VALIDATIONS #
  ###############
  validates :severity, presence: true

end
