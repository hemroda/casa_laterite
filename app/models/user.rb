# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  enum locale: %i[fr en]
  enum role: %i[user moderator admin]

  has_many :articles
  has_many :managers
  has_many :posts, dependent: :destroy
  has_many :projects, -> { order(created_at: :desc) }, as: :projectable, dependent: :destroy, inverse_of: :projectable
  has_many :tasks, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates :first_name, :last_name, presence: true

  def full_name
    return if first_name.nil? || last_name.nil?

    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def full_name_or_email
    full_name || email
  end

  def accounts_managed
    @accounts_managed ||= managers.where(manageable_type: "Account", unassigned_by: nil)
  end

  def properties_managed
    @properties_managed ||= managers.where(manageable_type: "Property", unassigned_by: nil)
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
