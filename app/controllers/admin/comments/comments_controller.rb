# frozen_string_literal: true

class Admin::Comments::CommentsController < Admin::CommentsController
  private
    def set_commentable
      @commentable = Comment.find(params[:comment_id])
    end
end
