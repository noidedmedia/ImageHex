module Forumable
  extend ActiveSupport::Concern

  included do
    has_many :topics,
      class_name: self.const_get(:Topic).name
  end
end
