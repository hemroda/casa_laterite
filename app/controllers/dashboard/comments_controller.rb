# frozen_string_literal: true

module Dashboard
  class CommentsController < ApplicationController
    layout "dashboard"

    before_action :authenticate_account!
    before_action :set_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.build(comment_params)
      @comment.submitted_by = current_account
      if @comment.save
        redirect_to dashboard_discussion_path(@commentable.find_top_parent.id), notice: "Comment created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
        redirect_back fallback_location: @commentable, notice: "Comment deleted"
      else
        redirect_back fallback_location: @commentable, alert: "Comment NOT deleted"
      end
    end

    private
      def comment_params
        params.require(:comment).permit(:content).merge(submitted_by: current_account)
      end
  end
end
