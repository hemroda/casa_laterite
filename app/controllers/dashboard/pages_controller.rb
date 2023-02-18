# frozen_string_literal: true

class Dashboard::PagesController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!

  def index
  end
end
