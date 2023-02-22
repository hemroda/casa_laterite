# frozen_string_literal: true

class Admin::ArticleCategoriesController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @q = ArticleCategory.includes(:articles).ransack(params[:q])
    @pagy, @article_categories = pagy(@q.result(distinct: true))
    @fields_to_search_in = :name_cont
  end

  def show
  end

  def new
    @article_category = ArticleCategory.new
  end

  def edit
  end

  def create
    @article_category = ArticleCategory.new(article_category_params)
    if @article_category.save
      redirect_to admin_article_category_path(@article_category),
                  notice: "Article Category created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article_category.update(article_category_params)
      redirect_to admin_article_category_path(@article_category),
                  notice: "The article category has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article_category.destroy
      redirect_to admin_article_categories_path,
                  notice: "The article category has been deleted."
    else
      redirect_to admin_article_categories_path,
                  alert: "The article category has NOT been deleted."
    end
  end

  private

  def set_article
    @article_category = ArticleCategory.find(params[:id])
  end

  def article_category_params
    params.require(:article_category).permit(:name)
  end
end
