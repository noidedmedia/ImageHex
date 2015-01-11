class FrontpageController < ApplicationController
  def index
    if current_user
      @images = current_user.image_feed
      render "index_with_user"
    else
      render "index"
    end
  end
end
