# frozen_string_literal: true

class Dashboard::Accounts::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    super
  end

  protected
    def after_resetting_password_path_for(_resource)
      # super(resource)
      account_session_path
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(_resource_name)
      # super(resource_name)
      account_session_path
    end

    def configure_devise_params
      devise_parameter_sanitizer.permit(:account_update, keys: %i[password password_confirmation])
    end
end
