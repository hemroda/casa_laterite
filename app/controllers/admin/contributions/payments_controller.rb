# frozen_string_literal: true

class Admin::Contributions::PaymentsController < Admin::PaymentsController
  private
    def set_payable
      @payable = Contribution.find(params[:contribution_id])
    end
end
