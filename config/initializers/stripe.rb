options = {
  site: "https://connect.stripe.com",
  authorize_url: "/oauth/authorize",
  token_url: "/oauth/token"
}
OAUTH_CLIENT = OAuth2::Client.new(ENV['STRIPE_CLIENT_ID'],
  ENV['STRIPE_SECRET_KEY'],
  options)
Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
