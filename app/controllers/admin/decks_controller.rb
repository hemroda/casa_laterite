# frozen_string_literal: true

module Admin
  class DecksController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_deck, only: %i[show edit update destroy reset_questions_proficiency_levels]

    def index
      @q = Deck.includes(:user).ransack(params[:q])
      @pagy, @decks = pagy(@q.result(distinct: true))
      @fields_to_search_in = :name_cont
    end

    def show; end

    def new
      @deck = Deck.new
    end

    def edit; end

    def create
      @deck = Deck.new(deck_params)
      if @deck.save
        redirect_to admin_deck_path(@deck), notice: "Deck created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @deck.update(deck_params)
        redirect_to admin_deck_path(@deck), notice: "The deck has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @deck.destroy
        redirect_to admin_decks_path, notice: "The deck has been deleted."
      else
        redirect_to admin_decks_path, alert: "The deck has NOT been deleted."
      end
    end

    def reset_questions_proficiency_levels
      ResetProficiencyLevelJob.perform_later(@deck)

      if @deck.questions_proficiency_levels_at_zero?
        redirect_to admin_decks_path, notice: "The deck's questions proficiency levels have been reset."
      else
        redirect_to admin_decks_path, notice: "The deck's questions proficiency levels have NOT been reset."
      end
    end

    private
      def set_deck
        @deck = Deck.includes(:questions).find(params[:id])
      end

      def deck_params
        params.require(:deck).permit(
          :name,
          :access_type,
          :user_id,
          :status,
          questions_attributes: [
            :_destroy,
            :id,
            :body,
            :proficiency_level,
            { answers_attributes: %i[_destroy id body] }
          ])
      end
  end
end
