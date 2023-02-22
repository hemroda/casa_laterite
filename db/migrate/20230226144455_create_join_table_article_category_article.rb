# frozen_string_literal: true

class CreateJoinTableArticleCategoryArticle < ActiveRecord::Migration[7.0]
  def change
    create_join_table :article_categories, :articles do |t|
      t.index [:article_category_id, :article_id], name: "article_category_for_article_index"
      t.index [:article_id, :article_category_id], name: "article_for_article_category_index"
    end
  end
end
