# frozen_string_literal: true

class Dashboard::Comments::CommentsController < Dashboard::CommentsController
  private
    def set_commentable
      @commentable = Comment.find(params[:comment_id])
    end
end
