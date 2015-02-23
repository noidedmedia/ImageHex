##
# This controller, essentially, is pointless.
# It serves to render completely static pages.
# At some point we should replace this with an NGINX thing or something.
class StaticStuffController < ApplicationController
  ##
  # About page. Info about the company you work at.
  def about
  end

  ##
  # People page. Info on your co-workers, and yourself.
  def people
  end

  ##
  # Contact page. How to talk to us.
  def contact
  end
end
