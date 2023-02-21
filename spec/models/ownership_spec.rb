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
