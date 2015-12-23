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
    code = params[:code]
    @resp = OAUTH_CLIENT.auth_code.get_token(code, 
                                             params: {scope: "read_write"})
    params = {
      :stripe_publishable_key => @resp["stripe_publishable_key"],
      :stripe_user_id => @resp["stripe_user_id"],
      :stripe_access_token => @resp.token
    }
  end
end
