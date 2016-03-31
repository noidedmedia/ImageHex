# frozen_string_literal: true
##
# A subjective collection is a type of collection which holds images with a subjective quality.
# Examples:
#  * Beautiful images
#  * Cool images
#  * Kawaii images
#
class Subjective < Collection
  ##
  # Made so this acts like a collection in dynamic routes and such
  def self.model_name
    Collection.model_name
  end
end
