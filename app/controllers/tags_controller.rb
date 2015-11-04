##
# A single-action controller used for tag suggestion.
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
  
  ##
  # Show a page with info about the tags
  def show
    @tag = Tag.friendly.find(params[:id])
    @images = @tag.images
      .paginate(page: page, per_page: per_page)
      .for_content(content_pref)
  end

  ##
  # Get a list of all tags
  # Maybe somebody will find this usefull?
  def index
    @tags = Tag.all.paginate(page: page, per_page: per_page)
  end

  ##
  # Edit this tag's description
  # We really should admin-restrict this at some point
  def edit
    @tag = Tag.friendly.find(params[:id])
  end

  ##
  # Update a tag's description
  # Should be admin-restricted at some point
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
  ##
  # Paramters.
  #
  # Of format:
  #     tag:
  #         description
  def tag_params
    params.require(:tag).permit(:description,
                                :display_name)
  end
end
