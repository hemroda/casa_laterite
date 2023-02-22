# frozen_string_literal: true

class Dashboard::Discussions::CommentsController < Dashboard::CommentsController
  private
    def set_commentable
      @commentable = Discussion.find(params[:discussion_id])
    end
end
