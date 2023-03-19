# frozen_string_literal: true

class Ticket < ApplicationRecord
  # Statuses includes the list of task statuses as constants.
  module Statuses
    NOT_STARTED = "not_started"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"
    ARCHIVED = "archived"
  end

  enum status: [Statuses::NOT_STARTED, Statuses::IN_PROGRESS, Statuses::COMPLETED, Statuses::ARCHIVED]
  enum ticket_type: %i[incident reclamation remboursement]

  belongs_to :ticketable, polymorphic: true
  belongs_to :discussion, optional: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :managers, -> { order(created_at: :desc) }, as: :manageable, dependent: :destroy, inverse_of: :manageable

  has_rich_text :description

  validates :name, :ticket_type, presence: true

  validate :set_start_date
  validate :set_completed_at

  def set_as_complete!
    self.completed!
    self.update_column(:completed_at, Time.now)
  end

  def reactivate!
    self.in_progress!
    self.update_column(:completed_at, nil)
  end

  private
    def set_start_date
      update_columns(start_date: DateTime.now, end_date: nil, completed_at: nil) if status_changed? && in_progress?
    end

    def set_completed_at
      update_column(:completed_at, DateTime.now) if status_changed? && completed?
    end
end


# ## Schema Information
#
# Table name: `tickets`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `bigint`           | `not null, primary key`
# **`completed_at`**     | `datetime`         |
# **`end_date`**         | `datetime`         |
# **`name`**             | `string`           | `not null`
# **`start_date`**       | `datetime`         |
# **`status`**           | `integer`          | `default("not_started")`
# **`ticket_type`**      | `integer`          | `not null`
# **`ticketable_type`**  | `string`           | `not null`
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`discussion_id`**    | `bigint`           |
# **`ticketable_id`**    | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_tickets_on_discussion_id`:
#     * **`discussion_id`**
# * `index_tickets_on_ticketable`:
#     * **`ticketable_type`**
#     * **`ticketable_id`**
#
