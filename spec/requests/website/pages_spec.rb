# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Website::Pages", type: :request do
  describe "GET /home" do
    before :each do
      get "/"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "has the right page title" do
      expect(response.body).to include "Casa Laterite"
    end
  end
end
