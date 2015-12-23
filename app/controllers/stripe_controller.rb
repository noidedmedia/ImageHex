class StripeController < ApplicationController
  before_action :ensure_user
  def authorize
    params = {
      :scope => "read_write",
      :redirect_uri => callback_stripe_index_url
    }
    url = OAUTH_CLIENT.auth_code.authorize_url(params)
    redirect_to url
  end
  def callback

  end
end
