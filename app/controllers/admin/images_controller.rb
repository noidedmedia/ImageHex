##
# Administrative actions relating to images. 
class Admin::ImagesController < Admin::AdminController
  def live

  end

  ##
  # Show all images that have been reported.
  # Sets the following variables:
  # @images:: Images that were reported.
  def index
    @images = Image.by_reports
  end

  ##
  # Delete an image for violating some of the almighty rules on ImageHex.
  # Redirects back to `/admin/images` so you can delete some more.
  # @image:: The image being deleted.
  def destroy
    @image = Image.find(params[:id]).destroy
    redirect_to "/admin/images"
  end
  
  ##
  # Remove all reports on the image in params[:id].
  # Used if people are reporting stuff they shouldn't.
  # @image:: The image being absolved.
  def absolve
    @image = Image.find(params[:id])
    @image.image_reports.update_all(active: false)
    redirect_to "/admin/images"
  end

end
