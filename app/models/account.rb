# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address, as: :addressable

  has_many :contributions
  has_many :comments, -> { order(created_at: :desc) }, as: :commentable, dependent: :destroy, inverse_of: :commentable
  has_many :discussions, as: :discussable, dependent: :destroy
  has_many :managers, -> { order(created_at: :desc) }, as: :manageable, dependent: :destroy, inverse_of: :manageable
  has_many :posts, dependent: :destroy
  has_many :ownerships, dependent: :nullify
  has_many :properties, through: :ownerships
  has_many :properties_projects, :through => :properties, :source => :projects
  has_many :shared_discussions, dependent: :destroy
  has_many :payments, through: :contributions
  has_many :tickets, -> { order(created_at: :desc) }, as: :ticketable, dependent: :destroy, inverse_of: :ticketable

  def full_name
    return if first_name.nil? || last_name.nil?

    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def full_name_or_email
    full_name || email
  end

  def lead_account_managers
    return if managers.empty?

    @lead_account_managers ||= managers.currently_assigned.where(lead_manager: true)
  end

  def assistant_account_managers
    return if managers.empty?

    @assistant_account_managers ||= managers.currently_assigned.where(lead_manager: false)
  end

  def validate_account!
    return false unless first_name.present? && last_name.present?

    self.update_columns(confirmed: true, confirmed_at: DateTime.new)
  end

  def valid_account?
    return false unless first_name.present? && last_name.present? && confirmed? == true

    true
  end

  def total_contribution_to(company_or_property)
    @total_contribution_to ||= company_or_property.contributions.where(account_id: id).where.not(validated_by: nil).sum(:amount) + company_or_property.payments.payed.where(payable_id: id).sum(:amount)
  end

  def project_ids
    @project_ids ||= companies_projects.pluck(:id) + properties_projects.pluck(:id)
  end
end
