##
# A controller that handles TagGroups.
# Only doesn't allow login on show.
class TagGroupsController < ApplicationController
  before_filter :ensure_user, except: :show
  before_filter :get_image
  include TrainTrack
  ##
  # Create a new TagGroup.
  # Sets:
  # @tag_group:: A new TagGroup, for form building.
  def new
    @tag_group = TagGroup.new
  end

  ##
  # POST to create a new TagGroup.
  # If successful, it redirects to the image.
  # Otherwise, it puts errors in flash[:errors] and renders the new 
  # action.
  # TODO: make this redirect to the new action
  def create
    @tag_group = TagGroup.create(tag_group_params)
    if @tag_group.save
      track @tag_group
      redirect_to @image
    else
      flash[:errors] = @tag_group.errors
      render 'new'
    end
  end

  ##
  # Display a page for editing tag groups.
  # @tag_group:: the group we will edit.
  def edit
    @tag_group = TagGroup.find(params[:id])
  end

  ##
  # PUT to update a TagGroup.
  # On success, redirects to the image.
  # On failure, renders the edit action again.
  def update
    @tag_group = TagGroup.find(params[:id])
    track @tag_group
    if @tag_group.update(tag_group_params)
      track @tag_group
      redirect_to @image
    else
      flash[:errors] = @tag_group.errors
      render 'edit'
    end
  end
  protected
  ##
  # Parameters to make a tag group.
  # Currently, it's essentially just at tag_group_string.
  # We add the image_id automatically from the path.
  def tag_group_params
    params.require(:tag_group)
      .permit(:tag_group_string)
      .merge(image_id: params[:image_id]) # Add in the image id automatically
  end
  ## 
  # Sets the image on every action.
  def get_image
    @image = Image.find(params[:image_id])
  end
end
