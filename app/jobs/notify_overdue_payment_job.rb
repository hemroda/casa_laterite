# frozen_string_literal: true

class NotifyOverduePaymentJob < ApplicationJob
  queue_as :default

  def perform(payment, notifier)
    Notification.create(noticeable: payment, sent_by: notifier, notification_type: Notification.notification_types["reminder"])
    payment.send_overdue_remainder_email
  end
end
