Rails.application.routes.draw do
  require "sidekiq/web"
  # TODO: uncomment when Devise is set up and User model created
  # authenticate :user do
  #   mount Sidekiq::Web => "/sidekiq"
  # end

  # Defines the root path route ("/")
  root "website/pages#homepage"

  # ADMIN
  namespace :admin, path: "/admin" do
    root "pages#dashboard"
  end

  # WEBSITE
  namespace :website, path: "/" do
    get "/", to: "pages#homepage"
  end
end
