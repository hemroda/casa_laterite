# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account, type: :model do
  let(:user) { create(:user) }
  let(:account) { create(:account, first_name: "john", last_name: "smith") }
  let(:nameless_account) { create(:account, first_name: nil, last_name: nil) }

  it "is valid with valid attributes" do
    expect(account).to be_valid
  end

  describe "#full_name" do
    context "when a account has a first_name and a last_name" do
      it "returns the account's full name" do
        expect(account.full_name).to eq("John Smith")
      end
    end

    context "when a account has no first_name nor last_name" do
      it "returns nil" do
        expect(nameless_account.full_name).to eq(nil)
      end
    end
  end

  describe "full_name_or_email" do
    context "when a account has a first_name and a last_name" do
      it "returns the account's full name" do
        expect(account.full_name_or_email).to eq("John Smith")
      end
    end

    context "when a account has no first_name nor last_name" do
      it "returns an email" do
        expect(nameless_account.full_name_or_email).to eq(nameless_account.email)
      end
    end
  end
end

# ## Schema Information
#
# Table name: `accounts`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `bigint`           | `not null, primary key`
# **`confirmation_sent_at`**    | `datetime`         |
# **`confirmation_token`**      | `string`           |
# **`confirmed`**               | `boolean`          | `default(FALSE)`
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
# **`locale`**                  | `integer`          | `default(0)`
# **`locked_at`**               | `datetime`         |
# **`phone_number`**            | `string`           |
# **`public_profile`**          | `boolean`          | `default(FALSE)`
# **`remember_created_at`**     | `datetime`         |
# **`reset_password_sent_at`**  | `datetime`         |
# **`reset_password_token`**    | `string`           |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`unconfirmed_email`**       | `string`           |
# **`unlock_token`**            | `string`           |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_accounts_on_confirmation_token` (_unique_):
#     * **`confirmation_token`**
# * `index_accounts_on_email` (_unique_):
#     * **`email`**
# * `index_accounts_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
# * `index_accounts_on_unlock_token` (_unique_):
#     * **`unlock_token`**
#
