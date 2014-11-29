class TagGroupsController < ApplicationController
  def new
    @tag_group = TagGroup.new
  end

  def create
    @tag_group = TagGroup.create(tag_group_params)
    if @tag_group.save
      redirect_to image
    else
      render 'new'
    end
  end



  protected
  def tag_group_params
    params.require(:tag_group)
      .permit(:tag_group_string)
      .merge(image_id: image.id) # Add in the image id automatically
  end
  def image
    Image.find(params[:image_id])
  end
end
