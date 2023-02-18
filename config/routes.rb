Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "website/pages#homepage"

  # ADMIN
  require "sidekiq/web"
  authenticate :user do
    mount Sidekiq::Web => "/sidekiq"
  end

  devise_for :users, controllers: {
    sessions: "admin/users/sessions",
    passwords: "admin/users/passwords",
    registrations: "admin/users/registrations",
    confirmations: "admin/users/confirmations",
    invitations: "admin/users/invitations"
  }

  namespace :admin, path: "/admin" do
    root "pages#dashboard"
    get "/system", to: "pages#system"
    post "check_background_jobs", to: "pages#check_background_jobs"

    resources :accounts
    resources :users
  end

  # DASHBOARD
  devise_for :accounts, controllers: {
    sessions: "dashboard/accounts/sessions",
    passwords: "dashboard/accounts/passwords",
    registrations: "dashboard/accounts/registrations",
    confirmations: "dashboard/accounts/confirmations",
    invitations: "dashboard/accounts/invitations",
  }

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    namespace :dashboard do
      root "pages#index"

      resources :accounts
    end
  end

  # WEBSITE
  namespace :website, path: "/" do
    get "/", to: "pages#homepage"
  end
end
