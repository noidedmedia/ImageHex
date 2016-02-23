# frozen_string_literal: true
class CommissionSubjectTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :commission_subject
end
