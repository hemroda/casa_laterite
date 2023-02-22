# frozen_string_literal: true

class Timer < ApplicationRecord
  belongs_to :task

  def duration
    return if end_at.blank?

    @duration ||= end_at.to_i - start_at.to_i
  end
end
