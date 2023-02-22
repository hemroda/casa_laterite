# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  commentable_type  :string           not null
#  submitted_by_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  commentable_id    :bigint           not null
#  submitted_by_id   :bigint
#
# Indexes
#
#  index_comments_on_commentable   (commentable_type,commentable_id)
#  index_comments_on_submitted_by  (submitted_by_type,submitted_by_id)
#
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :submitted_by, polymorphic: true, optional: true

  has_many :comments, as: :commentable, dependent: :destroy

  has_rich_text :content

  MIN_BODY_LENGTH = 3

  validates :content, presence: true
  validates :content, length: { minimum: MIN_BODY_LENGTH }
  validate :update_discussion_status, if: proc { |c| c.commentable.comments.length == 1 && commentable_type == "Discussion" }

  def find_top_parent
    return commentable unless commentable.is_a?(Comment)

    commentable.find_top_parent
  end

  protected
    def update_discussion_status
      commentable.in_progress!
      commentable.update_column(:start_date, DateTime.now)
    end
end
