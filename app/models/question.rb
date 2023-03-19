# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :deck, touch: true, inverse_of: :questions

  has_many :answers, dependent: :destroy

  has_rich_text :body

  validates :body, presence: true
  validate :answers_presence

  scope :not_full_proficiency, -> { where("proficiency_level < ?", 100) }
  scope :reviewed_before_today, -> { where("reviewed_at < ? OR reviewed_at IS NULL", Time.zone.now.beginning_of_day) }

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  def update_proficiency_level!(param)
    return unless self.deck.personal?

    deck.update_column(:reviewed_at, Time.now)
    self.update_columns(reviewed_at: Time.now, proficiency_level: (proficiency_level + (param)))
  end

  def reset_questions_proficiency_levels
    questions.each { |question| question.update_column(:proficiency_level, 0) }
  end

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
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`id`**                 | `bigint`           | `not null, primary key`
# **`proficiency_level`**  | `integer`          | `default(0)`
# **`reviewed_at`**        | `datetime`         |
# **`created_at`**         | `datetime`         | `not null`
# **`updated_at`**         | `datetime`         | `not null`
# **`deck_id`**            | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_questions_on_deck_id`:
#     * **`deck_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`deck_id => decks.id`**
#
