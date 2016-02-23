# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: "ImageHex <noreply@imagehex.com>"
  layout "mailer"
end
