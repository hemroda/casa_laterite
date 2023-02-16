class ApplicationMailer < ActionMailer::Base
  prepend_view_path "app/views/mailers"
  default from: ENV["AWS_SES_SENDER_EMAIL"]
  layout "mailer"
end
