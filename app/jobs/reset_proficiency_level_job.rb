# frozen_string_literal: true

class ResetProficiencyLevelJob < ApplicationJob
  queue_as :default

  def perform(deck)
    deck.reset_questions_proficiency_levels
  end
end
