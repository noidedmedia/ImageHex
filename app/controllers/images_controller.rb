class ImagesController < ApplicationController
  # Load the image via our id
  before_action :load_image, only: [:update, :edit, :destroy, :show]
  # Ensure a user is logged in. Defined in the application controller
  before_action :ensure_user, only: [:new, :create, :update, :edit, :destroy]
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image
    else
      # If their image is incorrect, redirect_to the new page again.
      flash[:error] = @image.errors.full_messages.join(", ")
      redirect_to :new
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end
  protected
  # Load the image with the current id into params[:image]
  def load_image
    @image = Image.find(params[:id])
  end
  def image_params
    params.require(:image)
    .permit(:f, :license, :medium) # Attributes the user adds
    .merge(user_id: current_user.id) # We add the user id
  end
end
