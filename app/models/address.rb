# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :line_one, :city, :zip_code, :country, presence: true

  has_rich_text :additional_information
end
