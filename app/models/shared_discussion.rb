# frozen_string_literal: true

class SharedDiscussion < ApplicationRecord
  belongs_to :discussion
  belongs_to :account
  belongs_to :removed_by, polymorphic: true, optional: true
  belongs_to :invited_by, polymorphic: true, optional: true
end

# ## Schema Information
#
# Table name: `shared_discussions`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `bigint`           | `not null, primary key`
# **`invited_by_type`**  | `string`           |
# **`removed_by_type`**  | `string`           |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`account_id`**       | `bigint`           |
# **`discussion_id`**    | `bigint`           |
# **`invited_by_id`**    | `bigint`           |
# **`removed_by_id`**    | `bigint`           |
#
# ### Indexes
#
# * `index_shared_discussions_on_account_id`:
#     * **`account_id`**
# * `index_shared_discussions_on_discussion_id`:
#     * **`discussion_id`**
# * `index_shared_discussions_on_invited_by`:
#     * **`invited_by_type`**
#     * **`invited_by_id`**
# * `index_shared_discussions_on_removed_by`:
#     * **`removed_by_type`**
#     * **`removed_by_id`**
#
