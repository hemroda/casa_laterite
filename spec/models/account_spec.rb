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
