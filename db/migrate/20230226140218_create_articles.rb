# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :published_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
