# frozen_string_literal: true

class Event < ApplicationRecord
  include Discard::Model

  enum event_type: %i[personal professional]

  belongs_to :user

  has_rich_text :description

  validates :title, :start_time, presence: true
  validate :cannot_end_before_it_starts

  scope :for_user, ->(user) { where(user_id: user.id) }

  def duration
    return nil if end_time.blank?

    @duration ||= end_time.to_i - start_time.to_i
  end

  def old_event
    @old_event ||= start_time < Time.now
  end

  protected

  def cannot_end_before_it_starts
    if end_time? && (end_time < start_time)
      errors.add(:end_time, " cannot be before the start date.")
    end
  end
end

# ## Schema Information
#
# Table name: `events`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `bigint`           | `not null, primary key`
# **`color`**         | `string`           |
# **`discarded_at`**  | `datetime`         |
# **`end_time`**      | `datetime`         |
# **`event_type`**    | `integer`          | `default("personal")`
# **`location`**      | `string`           |
# **`shared`**        | `boolean`          |
# **`start_time`**    | `datetime`         | `not null`
# **`title`**         | `string`           | `not null`
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`user_id`**       | `bigint`           |
#
# ### Indexes
#
# * `index_events_on_discarded_at`:
#     * **`discarded_at`**
# * `index_events_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
