# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  noticeable_type   :string           not null
#  notification_type :integer
#  sent_by_type      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  noticeable_id     :bigint           not null
#  sent_by_id        :bigint
#
# Indexes
#
#  index_notifications_on_noticeable  (noticeable_type,noticeable_id)
#  index_notifications_on_sent_by     (sent_by_type,sent_by_id)
#
class Notification < ApplicationRecord
  enum notification_type: %i[reminder]

  belongs_to :noticeable, polymorphic: true
  belongs_to :sent_by, polymorphic: true
end
