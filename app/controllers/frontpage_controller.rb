# frozen_string_literal: true
##
# We put the frontpage in a seperate controller, since it isn't
# static and also isn't RESTful.
#
# Users can see all the images in their feed here.
class FrontpageController < ApplicationController
  ##
  # Root of our site.
  def index
    if current_user
      after = if params[:fetch_after]
                Time.at(params[:fetch_after].to_f)
              else
                Time.zone.now
              end
      @images = current_user.image_feed
        .includes(:creators)
        .where("sort_created_at < ?", after)
        .limit(20)
      @notes = current_user.note_feed
        .where("notes.created_at < ?", after)
        .limit(20)
      render "index_with_user"
    else
      @images = Image.all
        .order('created_at DESC')
        .for_content(content_pref)
        .take(30)
      render "index"
    end
  end
end
