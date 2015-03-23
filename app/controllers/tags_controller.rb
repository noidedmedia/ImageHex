class TagsController < ApplicationController
  ##
  # This is an Api that only uses JSON, basiaclly
  # You send it part of a tag and it suggests other tags
  def suggest
    suggestions = Tag.suggest(params["name"].downcase)
    render json: suggestions
  end

end
