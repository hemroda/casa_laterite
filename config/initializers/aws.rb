creds = Aws::Credentials.new("AKIAVV7GLW5EORKVCJS6", "/Re0LGag1QH2gFYHMHsFGwLUojnm5W2X9Ydq+PJM")

Aws::Rails.add_action_mailer_delivery_method(
  :ses, # or :sesv2
  credentials: creds,
  region: "eu-west-3",
  # some other config
)
