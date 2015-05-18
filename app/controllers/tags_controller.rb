##
# A single-action controller used for tag suggestion.
# TODO: Allow users to modify information about tags in this controller.
class TagsController < ApplicationController
  ##
  # Given a partial tag name in "params['name']", suggests ten possible
  # completed tags in alphabetical order.
  # Renders a JSON data type.
  def suggest
    suggestions = Tag.suggest(params["name"].downcase)
    render json: suggestions
  end

  def index
    @tags = Tag.all.paginate(page: page, per_page: per_page)
  end

end
