# frozen_string_literal: true

class Milestone < ApplicationRecord
  module Statuses
    NOT_STARTED = "not_started"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"
    ARCHIVED = "archived"
  end

  enum status: [Statuses::NOT_STARTED, Statuses::IN_PROGRESS, Statuses::COMPLETED, Statuses::ARCHIVED]

  belongs_to :project, inverse_of: :milestones

  has_many :tasks, dependent: :destroy

  has_rich_text :description

  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank

  validates :name, :project, presence: true

  scope :for_project, ->(project) { where("project_id = ?", project.id) }

  def start!
    project.milestones.in_progress.first.not_started! unless project.milestones.in_progress.empty?

    self.in_progress!
  end

  def completed!
    self.update_columns(status: Statuses::COMPLETED, end_date: Time.current)
  end
end
