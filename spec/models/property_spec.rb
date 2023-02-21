# frozen_string_literal: true

require "rails_helper"

RSpec.describe Property, type: :model do
  let(:property) { create(:property, name: "Villa Marron") }
  let(:user) { create(:user, first_name: "john", last_name: "smith") }

  it "is valid with valid attributes" do
    expect(property).to be_valid
  end
end
