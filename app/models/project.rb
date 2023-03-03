# frozen_string_literal: true

class Project < ApplicationRecord
  enum status: %i[draft pending in_progress finished archived]
  enum visibility_type: %i[corporate personal]

  belongs_to :projectable, polymorphic: true
  belongs_to :project_type

  has_many :contributions, -> { order(created_at: :desc) }, as: :contributable, dependent: :destroy, inverse_of: :contributable
  has_many :managers, -> { order(created_at: :desc) }, as: :manageable, dependent: :destroy, inverse_of: :manageable
  has_many :milestones, dependent: :destroy
  has_many :tasks, dependent: :destroy

  has_one_attached :photo
  has_many_attached :photos
  has_many_attached :documents
  has_many_attached :images

  has_rich_text :description

  validates :name, presence: true
  validates :project_type, presence: true

  scope :tracked, -> { where(tracked: true) }
  scope :for_account, ->(account) { where("id in (?)", account.properties.pluck(:discussion_id)) }
  scope :for_user_personal, ->(user) { where("projectable_id = ? and projectable_type = ?", user.id, "User") }
  # scope :for_user, ->(user) { where("user_id = ? or id in (?)", user.id, user.shared_projects.kept.pluck(:project_id)) }
  scope :for_user_corporate, ->(user) { where("id in (?)", user.managers.where(manageable_type: "Project").pluck(:manageable_id))}

  def lead_project_managers
    return if managers.empty?

    @lead_project_managers ||= managers.currently_assigned.where(lead_manager: true)
  end

  def assistant_project_managers
    return if managers.empty?

    @assistant_project_managers ||= managers.currently_assigned.where(lead_manager: false)
  end

  def current_milestone
    @current_milestone ||= milestones.in_progress.first
  end

  def current_milestone_tasks
    return [] if milestones.empty? || tasks.empty? || milestones.in_progress.empty?

    @current_milestone_tasks ||= current_milestone.tasks
  end

  def tasks_with_no_milestone
    @tasks_with_no_milestone ||= tasks.where(milestone_id: nil)
  end

  def send_project_finished_email
    managers.includes(:user).each do |manager|
      ProjectMailer.with(project: self).project_finished_email(managers.user).deliver_later
    end
  end
end
