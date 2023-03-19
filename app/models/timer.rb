# frozen_string_literal: true

class Timer < ApplicationRecord
  belongs_to :task

  def duration
    return if end_at.blank?

    @duration ||= end_at.to_i - start_at.to_i
  end
end

# ## Schema Information
#
# Table name: `timers`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`end_at`**      | `datetime`         |
# **`start_at`**    | `datetime`         |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`task_id`**     | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_timers_on_task_id`:
#     * **`task_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`task_id => tasks.id`**
#
