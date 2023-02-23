# frozen_string_literal: true

module Admin
  class CommentsController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.build(comment_params)
      @comment.submitted_by = current_user
      if @comment.save
        redirect_to admin_discussion_path(@commentable), notice: "Comment created"
      else
        redirect_back fallback_location: @commentable, alert: "Comment NOT created"
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
        params.require(:comment).permit(:content)
      end
  end
end
