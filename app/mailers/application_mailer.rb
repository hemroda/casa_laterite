class ApplicationMailer < ActionMailer::Base
  prepend_view_path "app/views/mailers"
  default from: "hemroda@gmail.com"
  layout "mailer"
end
