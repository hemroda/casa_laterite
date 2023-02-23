# frozen_string_literal: true

module Dashboard
  class DiscussionsController < ApplicationController
    layout "dashboard"

    before_action :authenticate_account!
    before_action :set_discussion, only: %i[show edit update]
    before_action :set_discussable, only: %i[create]
    before_action :authorized_account, only: %i[ show ]

    def index
      @q = Discussion.includes(:discussable).for_account(current_account).ransack(params[:q])
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
        redirect_to dashboard_discussion_path(@discussion), notice: "The discussion has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private
      def authorized_account
        unless current_account.shared_discussions.pluck(:discussion_id).include?(@discussion.id)
          redirect_back fallback_location: dashboard_root_path, alert: I18n.t("dashboard.authorization.message")
        end
      end

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
