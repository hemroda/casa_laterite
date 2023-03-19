require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, first_name: "john", last_name: "smith", email: "jsmith@user.com") }
  let(:admin_user) { create(:user, role: 2) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  describe "#set_default_role" do
    context "when user's role is not specified" do
      it "returns the default role: user" do
        expect(user.role).to eq("user")
      end
    end

    context "when user's role is specified" do
      it "returns the specified role" do
        expect(admin_user.role).to eq("admin")
      end
    end
  end

  describe "#full_name" do
    context "when a user has a first_name and a last_name" do
      it "returns the user's full name" do
        expect(user.full_name).to eq("John Smith")
      end
    end

    context "when a user has no first_name nor last_name" do
      it "returns validation error message" do
        user.first_name = nil
        user.validate
        expect(user.errors[:first_name]).to include("can't be blank")
      end
    end
  end

  describe "#full_name_or_email" do
    context "when a user has a first_name and a last_name" do
      it "returns the user's full name" do
        expect(user.full_name_or_email).to eq("John Smith")
      end
    end

    context "when a user only has a first_name or a last_name" do
      it "returns the user's email" do
        user.first_name = nil
        expect(user.full_name_or_email).to eq("jsmith@user.com")
      end
    end
  end
end

# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `bigint`           | `not null, primary key`
# **`confirmation_sent_at`**    | `datetime`         |
# **`confirmation_token`**      | `string`           |
# **`confirmed_at`**            | `datetime`         |
# **`current_sign_in_at`**      | `datetime`         |
# **`current_sign_in_ip`**      | `string`           |
# **`email`**                   | `string`           | `default(""), not null`
# **`encrypted_password`**      | `string`           | `default(""), not null`
# **`failed_attempts`**         | `integer`          | `default(0), not null`
# **`first_name`**              | `string`           |
# **`last_name`**               | `string`           |
# **`last_sign_in_at`**         | `datetime`         |
# **`last_sign_in_ip`**         | `string`           |
# **`locale`**                  | `integer`          | `default("fr")`
# **`locked_at`**               | `datetime`         |
# **`phone_number`**            | `string`           |
# **`remember_created_at`**     | `datetime`         |
# **`reset_password_sent_at`**  | `datetime`         |
# **`reset_password_token`**    | `string`           |
# **`role`**                    | `integer`          | `default("user")`
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`unconfirmed_email`**       | `string`           |
# **`unlock_token`**            | `string`           |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_confirmation_token` (_unique_):
#     * **`confirmation_token`**
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
# * `index_users_on_unlock_token` (_unique_):
#     * **`unlock_token`**
#
