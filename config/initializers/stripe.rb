options = {
  :site => "https://connect.stripe.com",
  :authorize_url => "/stripe/authorize",
  :token_url => "/stripe/token"
}
OAUTH_CLIENT = OAuth2::Client.new(ENV['STRIPE_CLIENT_ID'],
                                  ENV['STRIPE_SECRET_KEY'],
                                  options)

