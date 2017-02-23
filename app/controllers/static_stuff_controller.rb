# frozen_string_literal: true
##
# This controller, essentially, is pointless.
# It serves to render completely static pages.
# At some point we should replace this with an NGINX thing or something.
class StaticStuffController < ApplicationController

  def terms_of_service
  end

  def guidelines
  end

  ##
  # About page. Information about what ImageHex is.
  def about
  end

  ##
  # Rules for posting on ImageHex.
  def rules
  end

  ##
  # People page. Info on persons who have helped develop ImageHex.
  def people
  end

  ##
  # Contact page. How to talk to us.
  def contact
  end

  ##
  # Frequently Asked Questions
  def faq
  end

  ##
  # The Help section.
  def help
  end

  ##
  # Press resources and whatnot.
  def press
  end
end
