# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :user, optional: true

  validates :content, length: { maximum: 250 }, presence: true

  scope :accounts_posts, -> { where(user_id: nil)}
  scope :users_posts, -> { where(account_id: nil)}
end

# ## Schema Information
#
# Table name: `posts`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`content`**     | `text`             |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`account_id`**  | `bigint`           |
# **`user_id`**     | `bigint`           |
#
# ### Indexes
#
# * `index_posts_on_account_id`:
#     * **`account_id`**
# * `index_posts_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`account_id => accounts.id`**
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
