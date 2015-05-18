##
# A single-action controller used for tag suggestion.
# TODO: Allow users to modify information about tags in this controller.
class TagsController < ApplicationController
  before_filter :ensure_user, only: [:edit, :update]
  ##
  # Given a partial tag name in "params['name']", suggests ten possible
  # completed tags in alphabetical order.
  # Renders a JSON data type.
  def suggest
    suggestions = Tag.suggest(params["name"].downcase)
    render json: suggestions
  end

  def show
    @tag = Tag.friendly.find(params[:id])
    @images = @tag.images.paginate(page: page, per_page: per_page)
  end
  def index
    @tags = Tag.all.paginate(page: page, per_page: per_page)
  end

  def edit
    @tag = Tag.friendly.find(params[:id])
  end

  def update
    tag = Tag.friendly.find(params[:id])
    if tag.update(tag_params)
      redirect_to tag
    else
      flash[:warning] = tags.errors.full_messages
      redirect_to action: :edit
    end

  end
  protected
  def tag_params
    params.require(:tag).permit(:description)
  end
end
