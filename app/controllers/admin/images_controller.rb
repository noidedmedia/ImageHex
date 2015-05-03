##
# Administrative actions relating to images. 
class Admin::ImagesController < Admin::AdminController
  ##
  # Show all images that have been reported.
  # Sets the following variables:
  # @images:: Images that were reported.
  def index
    @images = Image.by_reports
  end

  ##
  # Delete an image for violating some of the almighty rules on ImageHex.
  # Redirects back to /admin/images so you can delete some more.
  def destroy
    @image = Image.find(params[:id]).delete
    redirect_to "/admin/images"
  end
  ##
  # Remove all reports on the image in params[:id]
  # Used if people are reporting stuff they shouldn't.
  def absolve
    @image = Image.find(params[:id])
    @image.reports.map(&:delete)
    redirect_to "/admin/images"
  end

end
