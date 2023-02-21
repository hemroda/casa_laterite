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
    resources :addresses
    resources :managers, only: %i[create] do
      member do
        put :unassign_manager
        put :reassign_manager
        put :remove_as_lead
        put :set_as_lead
      end
    end
    resources :ownerships, only: %[create] do
      member do
        put :reallocate_account_to_property
        put :deallocate_account_from_property
      end
    end
    resources :posts
    get "my_posts", to: "posts#my_posts"
    resources :properties
    resources :property_types
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

  namespace :dashboard do
    root "pages#index"

    resources :accounts
    resources :posts
    get "my_posts", to: "posts#my_posts"
  end

  # WEBSITE
  namespace :website, path: "/" do
    get "/", to: "pages#homepage"
  end
end
