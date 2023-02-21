# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :user, optional: true

  validates :content, length: { maximum: 250 }, presence: true

  scope :accounts_posts, -> { where(user_id: nil)}
  scope :users_posts, -> { where(account_id: nil)}
end
