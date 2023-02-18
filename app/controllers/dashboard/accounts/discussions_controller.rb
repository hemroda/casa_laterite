# frozen_string_literal: true

class Dashboard::Accounts::DiscussionsController < Dashboard::DiscussionsController
  private
    def set_discussable
      @discussable = current_account
    end
end
