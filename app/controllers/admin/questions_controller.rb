# frozen_string_literal: true

class Admin::QuestionsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_question, only: %i[show edit update destroy proficiency_level_up proficiency_level_down]

  def index
    @questions = Question.all
  end

  def show; end

  def new
    @question = Question.new
  end

  def edit; end

  def create; end

  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question), notice: "The question has been updated."
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to admin_questions_path, notice: "The question has been deleted."
    else
      redirect_to admin_questions_path, alert: "The question has NOT been deleted."
    end
  end

  def proficiency_level_up
    redirect_back fallback_location: admin_deck_path(@question.deck_id) if @question.update_proficiency_level!(10)
  end

  def proficiency_level_down
    redirect_back fallback_location: admin_deck_path(@question.deck_id) if @question.update_proficiency_level!(-10)
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:body)
    end
end
