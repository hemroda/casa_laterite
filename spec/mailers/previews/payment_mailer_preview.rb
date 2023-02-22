# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/project
class PaymentMailerPreview < ActionMailer::Preview
  def invoice_verified_email
    PaymentMailer.with(payment: Payment.first).invoice_verified_email(Contribution.first)
  end

  def overdue_remainder_email
    PaymentMailer.with(payment: Payment.first).overdue_remainder_email(Contribution.first)
  end
end
