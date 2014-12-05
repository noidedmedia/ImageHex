class TagGroupsController < ApplicationController
  before_filter :ensure_user, except: :show
  before_filter :get_image
  before_filter :assign_group
  def new
    @tag_group = TagGroup.new
  end

  def create
    @tag_group = TagGroup.create(tag_group_params)
    if @tag_group.save
      redirect_to @image
    else
      render 'new'
    end
  end

  def edit
  end

  protected
  def tag_group_params
    params.require(:tag_group)
      .permit(:tag_group_string)
      .merge(image_id: image.id) # Add in the image id automatically
  end
  def get_image
    @image = Image.find(params[:image_id])
  end
  def assign_group
    @tag_group = TagGroup.find(params[:id])
  end
end
