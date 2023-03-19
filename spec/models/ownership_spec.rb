# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ownership, type: :model do
  let(:ownership) { create(:ownership) }

  it "is valid with valid attributes" do
    expect(ownership).to be_valid
  end

  describe "#already_a_ownership" do
    context "account is already listed as ownership of a property" do
      let(:duplicate_ownership) { build(:ownership, property_id: ownership.property_id, account_id: ownership.account_id) }

      it "returns false: This account is already a ownership" do
        expect(ownership.property.accounts.pluck(:id)).to eq([ownership.account_id])
        expect(duplicate_ownership).not_to be_valid
      end
    end
  end
end

# ## Schema Information
#
# Table name: `ownerships`
#
# ### Columns
#
# Name                       | Type               | Attributes
# -------------------------- | ------------------ | ---------------------------
# **`id`**                   | `bigint`           | `not null, primary key`
# **`allocated_by_type`**    | `string`           |
# **`deallocated_by_type`**  | `string`           |
# **`created_at`**           | `datetime`         | `not null`
# **`updated_at`**           | `datetime`         | `not null`
# **`account_id`**           | `bigint`           |
# **`allocated_by_id`**      | `bigint`           |
# **`deallocated_by_id`**    | `bigint`           |
# **`old_owner_id`**         | `integer`          |
# **`property_id`**          | `bigint`           |
#
# ### Indexes
#
# * `index_ownerships_on_account_id`:
#     * **`account_id`**
# * `index_ownerships_on_allocated_by`:
#     * **`allocated_by_type`**
#     * **`allocated_by_id`**
# * `index_ownerships_on_deallocated_by`:
#     * **`deallocated_by_type`**
#     * **`deallocated_by_id`**
# * `index_ownerships_on_property_id`:
#     * **`property_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`account_id => accounts.id`**
# * `fk_rails_...`:
#     * **`property_id => properties.id`**
#
