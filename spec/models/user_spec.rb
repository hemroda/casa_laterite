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
