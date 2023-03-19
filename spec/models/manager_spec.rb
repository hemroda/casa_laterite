# frozen_string_literal: true

require "rails_helper"

RSpec.describe Manager, type: :model do
  let(:user) { create(:user, first_name: "john", last_name: "smith") }
  let(:property_manager) { create(:user) }
  let(:property) { create(:property, name: "W Group") }
  let(:manager) { create(:manager, manageable: property, user: property_manager) }

  it "is valid with valid attributes" do
    expect(manager).to be_valid
  end


  describe "#reassign_as_manager!" do
    context "when reassigning a user to a property" do
      it "adds the property in the user's properties_managed list" do
        manager.unassign_as_manager!(user)
        expect(manager.assigned_by_type).to eq(nil)
        expect(manager.lead_manager).to eq(false)
        expect(manager.unassigned_by).to eq(user)

        expect(property_manager.properties_managed.count).to eq(0)

        manager.reassign_as_manager!(user)
        expect(manager.unassigned_by_type).to eq(nil)
        expect(manager.assigned_by).to eq(user)

        expect(property_manager.properties_managed.count).to eq(1)
      end
    end
  end

  describe "#unassign_as_manager!" do
    context "when a user is unassigned from property" do
      it "removes the property from the user's properties_managed list" do
        manager.unassign_as_manager!(user)
        expect(manager.assigned_by_type).to eq(nil)
        expect(manager.lead_manager).to eq(false)
        expect(manager.unassigned_by).to eq(user)

        expect(property_manager.properties_managed.count).to eq(0)
      end
    end
  end

  describe "#manager_unassigny" do
    context "when user is unassigned from a property" do
      it "returns the user who unassigned him or her" do
        manager.unassign_as_manager!(user)
        expect(manager.manager_unassigny).to eq("John Smith")
      end
    end

    context "when reassigning a user to a property" do
      it "returns nil for manager_unassigny" do
        manager.unassign_as_manager!(user)
        expect(manager.manager_unassigny).to eq("John Smith")

        manager.reassign_as_manager!(user)
        expect(manager.manager_unassigny).to eq(nil)
      end
    end
  end
end

# ## Schema Information
#
# Table name: `managers`
#
# ### Columns
#
# Name                      | Type               | Attributes
# ------------------------- | ------------------ | ---------------------------
# **`id`**                  | `bigint`           | `not null, primary key`
# **`assigned_by_type`**    | `string`           |
# **`lead_manager`**        | `boolean`          | `default(FALSE)`
# **`manageable_type`**     | `string`           | `not null`
# **`unassigned_by_type`**  | `string`           |
# **`created_at`**          | `datetime`         | `not null`
# **`updated_at`**          | `datetime`         | `not null`
# **`assigned_by_id`**      | `bigint`           |
# **`manageable_id`**       | `bigint`           | `not null`
# **`unassigned_by_id`**    | `bigint`           |
# **`user_id`**             | `bigint`           |
#
# ### Indexes
#
# * `index_managers_on_assigned_by`:
#     * **`assigned_by_type`**
#     * **`assigned_by_id`**
# * `index_managers_on_manageable`:
#     * **`manageable_type`**
#     * **`manageable_id`**
# * `index_managers_on_unassigned_by`:
#     * **`unassigned_by_type`**
#     * **`unassigned_by_id`**
# * `index_managers_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
