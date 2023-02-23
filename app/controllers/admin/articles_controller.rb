# frozen_string_literal: true

class Admin::ArticlesController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @q = Article.includes([:article_categories, :user]).ransack(params[:q])
    @pagy, @articles = pagy(@q.result(distinct: true))
    @fields_to_search_in = :title_cont
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_article_path(@article), notice: "Article created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to admin_article_path(@article), notice: "The article has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      redirect_to admin_articles_path, notice: "The article has been deleted."
    else
      redirect_to admin_articles_path, alert: "The article has NOT been deleted."
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(
        :title,
        :content,
        :user_id,
        :content,
        :status,
        :published_at,
        article_category_ids: []
      )
    end
end
