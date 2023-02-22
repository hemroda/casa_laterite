# frozen_string_literal: true

class ProjectType < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
