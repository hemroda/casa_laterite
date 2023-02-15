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

    resources :users
  end

  # WEBSITE
  namespace :website, path: "/" do
    get "/", to: "pages#homepage"
  end
end
