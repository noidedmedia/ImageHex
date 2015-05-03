##
# A subjective collection is a type of collection which holds images with a subjective quality.
# Examples:
#  * Beautiful images
#  * Cool images
#  * Kawaii images
#
class Subjective < Collection
  def self.model_name
    Collection.model_name
  end
end
