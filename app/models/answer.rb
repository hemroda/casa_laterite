# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question, touch: true, inverse_of: :answers

  has_rich_text :body

  validates :body, presence: true
end

# ## Schema Information
#
# Table name: `answers`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `bigint`           | `not null, primary key`
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`question_id`**  | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_answers_on_question_id`:
#     * **`question_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`question_id => questions.id`**
#
