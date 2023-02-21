# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  completed_at :datetime
#  description  :text
#  end_date     :datetime
#  name         :string
#  start_date   :datetime
#  status       :integer          default("not_started")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  milestone_id :bigint
#  project_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_tasks_on_milestone_id  (milestone_id)
#  index_tasks_on_project_id    (project_id)
#  index_tasks_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (milestone_id => milestones.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  # Statuses includes the list of task statuses as constants.
  module Statuses
    NOT_STARTED = "not_started"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"
    ARCHIVED = "archived"
  end

  enum status: [Statuses::NOT_STARTED, Statuses::IN_PROGRESS, Statuses::COMPLETED, Statuses::ARCHIVED]

  belongs_to :milestone, optional: true
  belongs_to :project, optional: true
  belongs_to :user, optional: true

  has_many :timers, dependent: :destroy
  has_many :todo_items, dependent: :destroy

  has_rich_text :description

  accepts_nested_attributes_for :todo_items, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true

  validate :proper_status_for_no_project, if: proc { |t| t.project_id.nil? && t.new_record? }

  scope :for_user, ->(user) { where("user_id = ? and project_id IS NULL", user.id) }

  def set_as_complete!
    return if completed_todo_items_percentage < 100 && !todo_items.empty?

    self.completed!
    self.update_column(:completed_at, Time.now)
  end

  def reactivate!
    self.in_progress!
    self.update_column(:completed_at, nil)
  end

  def completed_items
    @completed_items ||= todo_items.completed.length
  end

  def total_items
    @total_items ||= todo_items.length
  end

  def completed_todo_items_percentage
    return 0 if total_items.zero?

    @completed_todo_items_percentage ||= (100 * completed_items.to_f / total_items).round(1)
  end

  def todo_items_progression
    @todo_items_progression ||= "#{todo_items.completed.length} / #{todo_items.length}"
  end

  def total_time_spent_on_task
    @tasks ||= timers.collect { |timer| timer.duration }
    @total_time_spent_on_task ||= @tasks.sum unless @tasks.include?(nil)

    return nil if @total_time_spent_on_task.nil?

    @total_time_spent_on_task
  end

  def current_timer
    @current_timer ||= timers.where(end_at: nil).first
  end

  protected
    # Proper status for tasks listed on admin dashboard.
    def proper_status_for_no_project
      self.status = "in_progress"
    end
end
