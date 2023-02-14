Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "website/pages#homepage"

  # WEBSITE
  namespace :website, path: "/" do
    get "/", to: "pages#homepage"
  end
end
