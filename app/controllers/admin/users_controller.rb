# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorized_users, only: %i[edit update destroy]

  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true))
    @fields_to_search_in = :email_or_first_name_or_last_name_cont
  end

  def show
    @projects = Project.for_user_personal(current_user)
    @properties_managed = @user.properties_managed.includes([:manageable])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "User created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "The user has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "The user has been deleted."
    else
      redirect_to admin_users_path, alert: "The user has NOT been deleted."
    end
  end

  private

  def authorized_users
    unless current_user.admin? || current_user == @user
      redirect_back fallback_location: admin_users_path,
                    alert: "No can do buddy."
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password,
      :password_confirmation
    )
  end
end
