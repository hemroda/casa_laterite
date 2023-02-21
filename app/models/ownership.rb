# frozen_string_literal: true

class Ownership < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :property
  belongs_to :allocated_by, polymorphic: true, optional: true
  belongs_to :deallocated_by, polymorphic: true, optional: true

  validate :already_a_owner

  def reallocate_account_to_property!(user)
    self.deallocated_by = nil
    self.allocated_by = user
    self.account = old_owner
    self.old_owner_id = nil
    save
  end

  def deallocate_account_from_property!(user)
    self.allocated_by = nil
    self.deallocated_by = user
    self.old_owner_id = account_id
    self.account = nil
    save
  end

  def old_owner
    @old_owner ||= Account.find(old_owner_id) unless old_owner_id.nil?
  end

  private
  def already_a_owner
    if new_record? && property.accounts.pluck(:id).include?(account_id)
      errors.add(:base, "This account is already a owner")
    end
  end
end
