# frozen_string_literal: true

class Website::ArticlesController < ApplicationController
  layout "website"

  before_action :set_article, only: %i[show]

  def index
    @q = Article.published.order(published_at: :desc).ransack(params[:q])
    @pagy, @articles = pagy(@q.result(distinct: true))
    @fields_to_search_in = :title_or_content_cont
  end

  def show; end

  private
    def set_article
      @article = Article.find(params[:id])
    end
end
