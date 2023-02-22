# frozen_string_literal: true

class Dashboard::Properties::DiscussionsController < Dashboard::DiscussionsController
  private
    def set_discussable
      @discussable = Property.find(params[:property_id])
    end
end
