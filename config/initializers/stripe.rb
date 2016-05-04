Rails.configuration.stripe = {

  :publishable_key => "#{ENV['stripe_test_publishable']}",

  :secret_key => "#{ENV['stripe_test_secret']}"

}

Stripe.api_key = Rails.configuration.stripe[:secret_key]