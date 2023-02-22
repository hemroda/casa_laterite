# frozen_string_literal: true

class TodoItem < ApplicationRecord
  belongs_to :task, optional: true

  validates :title, presence: true

  scope :completed, -> { where(completed: true) }

  def completed!
    self.update_columns(completed: true, completed_at: Time.current)

    update_task_status
  end

  def reactivate!
    self.update_columns(completed: false, completed_at: nil)

    update_task_status
  end

  protected
    def update_task_status
      return if task.nil?

      if task.todo_items.completed.length == task.todo_items.length
        task.update_columns(status: Task::Statuses::COMPLETED, completed_at: Time.now)
      else
        task.update_columns(status: Task::Statuses::IN_PROGRESS, completed_at: nil)
      end
    end
end
