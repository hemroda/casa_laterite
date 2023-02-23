# frozen_string_literal: true

class Discussion < ApplicationRecord
  module Statuses
    NOT_STARTED = "not_started"
    IN_PROGRESS = "in_progress"
    ARCHIVED = "archived"
  end

  enum status: [Statuses::NOT_STARTED, Statuses::IN_PROGRESS, Statuses::ARCHIVED]

  belongs_to :discussable, polymorphic: true

  has_many :comments, -> { order(created_at: :desc) }, as: :commentable, dependent: :destroy, inverse_of: :commentable
  has_many :managers, -> { order(created_at: :desc) }, as: :manageable, dependent: :destroy, inverse_of: :manageable
  has_many :shared_discussions, dependent: :destroy
  has_many :tickets, dependent: :destroy

  has_rich_text :description

  scope :for_account, ->(account) { where("id in (?)", account.shared_discussions.pluck(:discussion_id)) }

  validates :subject, :description, presence: true

  def first_discussion_member(account_id, discussion_id, inviter)
    SharedDiscussion.create(account_id: account_id, discussion_id: discussion_id, invited_by: inviter)
  end

  def generate_ticket_incident!
    Ticket.create(ticketable_type: discussable_type, ticketable_id: discussable_id, ticket_type: :incident,
               name: "About issue mentionned in discussion ##{id}", discussion_id: id)
  end

  def find_top_parent
    return self
  end
end
