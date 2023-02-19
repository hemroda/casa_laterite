# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :building, class_name: "Property", optional: true
  belongs_to :property_type

  has_rich_text :description

  validates :name, :headline, presence: true

end
