# frozen_string_literal: true

class Deck < ApplicationRecord
  enum status: %i[draft in_progress archived]
  enum access_type: %i[personal global]

  belongs_to :user

  has_many :questions, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  scope :for_user, ->(user) { where("user_id = ? and access_type = ?", user.id, access_types[:personal]) }
  scope :for_everyone, -> { where(access_type: access_types[:global]) }

  def reset_questions_proficiency_levels
    self.questions.each { |question| question.update_columns(proficiency_level: 0, reviewed_at: Date.yesterday.beginning_of_day) }
  end

  def questions_proficiency_levels_at_zero?
    @questions_proficiency_levels_at_zero ||= questions.where(proficiency_level: 1..).count.zero?
  end

  def average_proficiency_level
    return 0 if questions.empty?

    @average_proficiency_level ||= (100 * questions.sum(:proficiency_level) / (questions.count * 100))
  end
end

# ## Schema Information
#
# Table name: `decks`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `bigint`           | `not null, primary key`
# **`access_type`**  | `integer`          | `default("personal")`
# **`name`**         | `string`           | `not null`
# **`reviewed_at`**  | `datetime`         |
# **`status`**       | `integer`          | `default("draft")`
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`user_id`**      | `bigint`           |
#
# ### Indexes
#
# * `index_decks_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
