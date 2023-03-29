# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :campaign, touch: true, inverse_of: :questions

  has_many :answers, dependent: :destroy

  has_rich_text :body

  validates :body, presence: true
  validate :answers_presence

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  protected
    def answers_presence
      errors.add(:answers, ": A Question can't be save without an answer.") if answers.empty?
    end
end

# ## Schema Information
#
# Table name: `questions`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `bigint`           | `not null, primary key`
# **`reviewed_at`**  | `datetime`         |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`campaign_id`**  | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_questions_on_campaign_id`:
#     * **`campaign_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`campaign_id => campaigns.id`**
#
