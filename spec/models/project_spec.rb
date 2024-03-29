# frozen_string_literal: true

require "rails_helper"

RSpec.describe Project, type: :model do
  let(:project) { create(:project) }
  let(:user) { create(:user, first_name: "john", last_name: "smith") }

  it "is valid with valid attributes" do
    expect(project).to be_valid
  end

  describe "#lead_project_managers" do
    context "when NO project managers are assigned to project" do
      it "returns the nil" do
        expect(project.lead_project_managers).to eq(nil)
      end
    end

    context "when project managers are assigned to project" do
      let(:project_manager1) { create(:user) }
      let(:project_manager2) { create(:user) }
      let(:manager1) { create(:manager, manageable: project, user: project_manager1) }
      let(:manager2) { create(:manager, manageable: project, user: project_manager2) }

      it "returns the lead project manager" do
        manager1.lead_manager = true
        manager1.save
        expect(project.lead_project_managers.count).to eq(1)
        expect(project.lead_project_managers.first.user).to eq(manager1.user)
      end
    end
  end

  describe "#assistant_project_managers" do
    context "when NO project managers are assigned to project" do
      it "returns the nil" do
        expect(project.assistant_project_managers).to eq(nil)
      end
    end

    context "when project managers are assigned to project" do
      let(:project2) { create(:project, name: "W Group's project #1") }
      let(:project_manager3) { create(:user) }
      let(:project_manager4) { create(:user) }
      let(:manager3) { create(:manager, manageable: project2, user: project_manager3, assigned_by: user) }
      let(:manager4) { create(:manager, manageable: project2, user: project_manager4, assigned_by: user) }

      it "returns the assistant project manager" do
        project2.managers = [manager3, manager4]
        expect(project2.assistant_project_managers.count).to eq(2)
        expect(project2.assistant_project_managers.first.user).to eq(manager4.user)
      end
    end
  end
end

# ## Schema Information
#
# Table name: `projects`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `bigint`           | `not null, primary key`
# **`completed_at`**      | `datetime`         |
# **`description`**       | `text`             |
# **`end_date`**          | `datetime`         |
# **`name`**              | `string`           |
# **`projectable_type`**  | `string`           | `not null`
# **`start_date`**        | `datetime`         |
# **`status`**            | `integer`          | `default("draft")`
# **`tracked`**           | `boolean`          | `default(FALSE)`
# **`visibility_type`**   | `integer`          | `default("corporate")`
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
# **`project_type_id`**   | `bigint`           | `not null`
# **`projectable_id`**    | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_projects_on_project_type_id`:
#     * **`project_type_id`**
# * `index_projects_on_projectable`:
#     * **`projectable_type`**
#     * **`projectable_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`project_type_id => project_types.id`**
#
