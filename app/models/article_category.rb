# frozen_string_literal: true

class ArticleCategory < ApplicationRecord
  has_and_belongs_to_many :articles

  validates :name, presence: true
end
