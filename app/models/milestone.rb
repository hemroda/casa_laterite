# frozen_string_literal: true

# == Schema Information
#
# Table name: milestones
#
#  id         :bigint           not null, primary key
#  end_date   :datetime
#  name       :string
#  start_date :datetime
#  status     :integer          default("not_started")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#
# Indexes
#
#  index_milestones_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
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
