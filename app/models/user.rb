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

  has_many :posts, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates :first_name, :last_name, presence: true

  def full_name
    return if first_name.nil? || last_name.nil?

    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def full_name_or_email
    full_name || email
  end
end
