# frozen_string_literal: true

module Admin
  class DiscussionsController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_discussion, only: %i[show edit update]
    before_action :set_discussable, only: %i[create]

    def index
      @q = Discussion.includes([:discussable]).ransack(params[:q])
      @pagy, @discussions = pagy(@q.result(distinct: true))
      @fields_to_search_in = :subject_cont
    end

    def show
      @commentable = @discussion
      @comment = Comment.new
      @comments = @discussion.comments.sort_by { |c| c.created_at }
    end

    def new
      @discussion = Discussion.new
    end

    def edit; end

    def create
      @discussion = @discussable.discussions.build(discussion_params)
      if @discussion.save
        @discussion.first_discussion_member(current_account.id, @discussion.id, current_account)
        redirect_back fallback_location: @discussable, notice: "La discussion est créée!"
      else
        redirect_back fallback_location: @discussable, alert: "La discussion n'a pas été créée ! #{@discussion.errors.full_messages.to_sentence.capitalize}"
      end
    end

    def update
      if @discussion.update(discussion_params)
        redirect_to admin_discussion_path(@discussion), notice: "The discussion has been updated."
      else
        render :edit, status: :unprocessable_entity
        redirect_back fallback_location: @discussion, alert: "The discussion has not been updated"
      end
    end

    private
      def set_discussion
        @discussion = Discussion.find(params[:id])
      end

      def discussion_params
        params.require(:discussion).permit(
          :id,
          :subject,
          :description,
          :status,
          :start_date,
          :end_date,
        )
    end
  end
end
