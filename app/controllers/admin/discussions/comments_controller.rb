# frozen_string_literal: true

class Admin::Discussions::CommentsController < Admin::CommentsController
  private
    def set_commentable
      @commentable = Discussion.find(params[:discussion_id])
    end
end
