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

# ## Schema Information
#
# Table name: `articles`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `bigint`           | `not null, primary key`
# **`content`**       | `text`             | `not null`
# **`published_at`**  | `datetime`         |
# **`status`**        | `integer`          | `default("draft")`
# **`title`**         | `string`           | `not null`
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`user_id`**       | `bigint`           |
#
# ### Indexes
#
# * `index_articles_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
