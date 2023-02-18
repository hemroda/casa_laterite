# frozen_string_literal: true

class Admin::AccountsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_account, only: %i[show edit update destroy]

  def index
    @q = Account.ransack(params[:q])
    @pagy, @accounts = pagy(@q.result(distinct: true))
    @fields_to_search_in = :email_or_first_name_or_last_name_cont
  end

  def show; end

  def new
    @account = Account.new
  end

  def edit; end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to admin_accounts_path, notice: "Account was created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @account.destroy
      redirect_to admin_accounts_path, notice: "The account has been deleted."
    else
      redirect_to admin_accounts_path, alert: "The account has NOT been deleted."
    end
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(
        :first_name,
        :last_name,
        :email,
        :phone_number,
        :password,
        :password_confirmation
      )
    end
end
