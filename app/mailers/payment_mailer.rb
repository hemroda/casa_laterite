# frozen_string_literal: true

class PaymentMailer < ApplicationMailer
  default from: "Laterite Team <no-reply@laterite.casa>"

  def invoice_verified_email(contribution)
    @payment = params[:payment]
    @payer = contribution.account.full_name
    @url  = "#{ENV['MAIL_HOST']}/dashboard/contributions/#{contribution.id}/payments/#{@payment.id}"

    mail(to: contribution.account.email, subject: "Your payment has been validated!")
  end

  def overdue_remainder_email(contribution)
    @payment = params[:payment]
    @payer = contribution.account
    @url  = "#{ENV['MAIL_HOST']}/dashboard/contributions/#{contribution.id}"

    mail(to: contribution.account.email, subject: "#{ I18n.t('emails.overdue_remainder_email.subject', locale: @payer.locale) }")
  end
end
