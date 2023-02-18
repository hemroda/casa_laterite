# frozen_string_literal: true

class Dashboard::AccountsController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!
  before_action :set_account, only: %i[show edit update destroy feed]
  before_action :authorized_accounts, only: %i[show edit update destroy]

  def index
    @pagy, @accounts = pagy(Account.all)
  end

  def show; end

  def edit; end

  def update
    if @account.update(account_params)
      redirect_to dashboard_account_path(@account), notice: "The account has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @account.destroy
      redirect_to dashboard_accounts_path, notice: "The account has been deleted."
    else
      redirect_to dashboard_accounts_path, alert: "The account has NOT been deleted."
    end
  end

  def feed
    @microposts = @account.microposts
  end

  private
    def authorized_accounts
      redirect_back fallback_location: dashboard_root_path, alert: "No can do buddy." unless current_account.id == @account.id
    end

    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(
        :first_name,
        :last_name,
        :email,
        :phone_number
      )
    end
end
