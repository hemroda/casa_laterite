# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:unprocessable_entity]

  def not_found
    respond_to do |format|
      format.html { render status: 404 }
      format.all  { head :not_found }
    end
  end

  def unprocessable_entity
    respond_to do |format|
      format.html { render status: 422 }
      format.all  { head :unprocessable_entity }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render status: 500 }
      format.all  { head :internal_server_error }
    end
  end
end
