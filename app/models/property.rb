# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :building, class_name: "Property", optional: true
  belongs_to :property_type

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_many_attached :photos
  has_many_attached :documents

  has_rich_text :description

  validates :name, :headline, presence: true

end
