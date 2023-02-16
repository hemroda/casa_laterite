class ApplicationMailer < ActionMailer::Base
  prepend_view_path "app/views/mailers"
  default from: ENV["SES_SENDER_EMAIL"]
  layout "mailer"
end
