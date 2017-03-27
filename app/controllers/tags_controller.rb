# frozen_string_literal: true
##
# A single-action controller used for tag suggestion.
class TagsController < ApplicationController
  include TrainTrack
  before_action :ensure_user, only: [:edit, :update]

  ##
  # Given a partial tag name in "params['name']", suggests ten possible
  # completed tags in alphabetical order.
  # Renders a JSON data type.
  def suggest
    if params["name"]
      suggestions = Tag.suggest(params["name"].downcase)
      render json: suggestions
    else
      render status: 422, body: nil
    end
  end

  ##
  # Show a page with info about the tags.
  # @tag:: The tag in question.
  # @neighbors:: Related tags.
  # @images:: Images tagged with the given tag.
  def show
    @tag = Tag.friendly.find(params[:id])
    @neighbors = @tag.neighbors.limit(10)
    @topics = @tag.topics.order(updated_at: :desc)
    @images = @tag.images
      .group("images.id")
      .for_content(content_pref)
      .paginate(page: page, per_page: per_page)
  end

  ##
  # Get a list of all tags.
  # Maybe somebody will find this useful?
  # @tags:: All the tags.
  def index
    @tags = Tag.all
      .for_content(content_pref)
      .paginate(page: page, per_page: per_page)
  end

  ##
  # Create a new tag.
  # @tag:: The tag being created.
  def new
    @tag = Tag.new
  end

  ##
  # Creates a tag.
  # @tag:: The tag being created.
  def create
    @tag = Tag.new(tag_params)
    respond_to do |format|
      if @tag.save
        track @tag
        format.html { redirect_to @tag }
        format.json { render 'show' }
      else
        format.html { render 'edit' }
        format.json { render json: @tag.errors, status: :unproccessible_entity }
      end
    end
  end

  ##
  # Edit this tag's description.
  # FIXME: We really should admin-restrict this at some point.
  # @tag:: The tag being edited.
  def edit
    @tag = Tag.friendly.find(params[:id])
  end

  ##
  # Update a tag's description
  # Should be admin-restricted at some point
  def update
    tag = Tag.friendly.find(params[:id])
    track tag
    if tag.update(tag_params)
      track tag
      redirect_to tag
    else
      flash[:warning] = tag.errors.full_messages
      redirect_to action: :edit
    end
  end

  protected

  ##
  # Parameters.
  #
  # Of format:
  #     tag:
  #         description
  def tag_params
    params.require(:tag).permit(:description,
                                :importance,
                                :name)
  end
end
