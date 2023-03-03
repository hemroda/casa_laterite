# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :building, class_name: "Property", optional: true
  belongs_to :property_type

  has_one :address, as: :addressable

  has_many :ownerships
  has_many :accounts, through: :ownerships
  has_many :contributions, -> { order(created_at: :desc) }, as: :contributable, dependent: :destroy, inverse_of: :contributable
  has_many :discussions, as: :discussable, dependent: :destroy
  has_many :managers, -> { order(created_at: :desc) }, as: :manageable, dependent: :destroy, inverse_of: :manageable
  has_many :projects, -> { order(created_at: :desc) }, as: :projectable, dependent: :destroy, inverse_of: :projectable
  has_many :payments, through: :contributions
  has_many :units, class_name: "Property", foreign_key: "building_id"

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_many_attached :photos
  has_many_attached :documents

  has_rich_text :description

  accepts_nested_attributes_for :ownerships, allow_destroy: true, reject_if: :all_blank

  accepts_nested_attributes_for :address, allow_destroy: true, reject_if: :all_blank

  validates :name, :headline, presence: true
  validate :year_built_not_in_the_future
  validates_associated :address

  after_save :not_for_land_type_property

  def lead_property_managers
    return if managers.empty?

    @lead_property_managers ||= managers.includes([:user]).currently_assigned.where(lead_manager: true)
  end

  def assistant_property_managers
    return if managers.empty?

    @assistant_property_managers ||= managers.includes([:user]).currently_assigned.where(lead_manager: false)
  end

  def total_contribution
    @total_contribution ||= self.contributions.sum(:amount) + self.payments.sum(:amount)
    # Take only into account voluntary contributions types that where validated i.e "payed"
    @total_payed_contribution ||= self.contributions.where.not(validated_by: nil).sum(:amount) + self.payments.payed.sum(:amount)

    { total_contribution: @total_contribution, total_payed_contribution: @total_payed_contribution }
  end

  protected
  def year_built_not_in_the_future
    return if year_built.nil?

    errors.add(:year_built, message: "cannot be set in the future") if year_built > Time.now
  end

  def not_for_land_type_property
    update_columns(year_built: nil, rooms: nil, bathrooms: nil) if property_type.name == "Land"
  end
end

