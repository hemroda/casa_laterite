# frozen_string_literal: true

class ProjectType < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end

# ## Schema Information
#
# Table name: `project_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`name`**        | `string`           | `not null`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
