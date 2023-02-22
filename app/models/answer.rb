# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question, touch: true, inverse_of: :answers

  has_rich_text :body

  validates :body, presence: true
end
