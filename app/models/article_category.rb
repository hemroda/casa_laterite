# frozen_string_literal: true

class ArticleCategory < ApplicationRecord
  has_and_belongs_to_many :articles

  validates :name, presence: true
end

# ## Schema Information
#
# Table name: `article_categories`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`name`**        | `string`           |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
