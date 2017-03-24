module Replyable
  extend ActiveSupport::Concern

  included do
    has_many :replies,
      class_name: self.const_get(:Reply).name
  end
end
