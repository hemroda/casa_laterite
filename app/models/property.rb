# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :building, class_name: "Property", optional: true
  belongs_to :property_type

  has_one :address, as: :addressable

  has_many :ownerships
  has_many :accounts, through: :ownerships
  has_many :managers, -> { order(created_at: :desc) }, as: :manageable, dependent: :destroy, inverse_of: :manageable
  has_many :projects, -> { order(created_at: :desc) }, as: :projectable, dependent: :destroy, inverse_of: :projectable

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_many_attached :photos
  has_many_attached :documents

  has_rich_text :description

  accepts_nested_attributes_for :ownerships, allow_destroy: true, reject_if: :all_blank

  validates :name, :headline, presence: true

  def lead_property_managers
    return if managers.empty?

    @lead_property_managers ||= managers.currently_assigned.where(lead_manager: true)
  end

  def assistant_property_managers
    return if managers.empty?

    @assistant_property_managers ||= managers.currently_assigned.where(lead_manager: false)
  end
end

