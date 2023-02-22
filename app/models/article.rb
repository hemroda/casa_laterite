# frozen_string_literal: true

class Article < ApplicationRecord
  enum status: %i[draft published archived]

  belongs_to :user

  has_and_belongs_to_many :article_categories

  # has_rich_text :content

  validates :title, :content, presence: true
  validates :user_id, presence: true
  validate :set_published_at

  private

  def set_published_at
    update_column(:published_at, DateTime.now) if status_changed? && published?
  end
end
