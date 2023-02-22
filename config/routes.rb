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
    resources :articles
    resources :article_categories
    resources :decks do
      member { put :reset_questions_proficiency_levels }
    end
    resources :contributions do
      resources :payments, only: %i[new create destroy], module: :contributions
      member do
        put :validate
      end
    end
    resources :events do
      member do
        put :discard
        put :undiscard
      end
    end
    resources :managers, only: %i[create] do
      member do
        put :unassign_manager
        put :reassign_manager
        put :remove_as_lead
        put :set_as_lead
      end
    end
    resources :milestones do
      member do
        put :not_started
        put :start
        put :complete
        put :reactivate
        put :archive
      end
    end
    resources :ownerships, only: %[create] do
      member do
        put :reallocate_account_to_property
        put :deallocate_account_from_property
      end
    end
    resources :payments, only: %i[index new create destroy edit update] do
      member do
        put :validate_invoice
        put :overdue_payment_reminder
      end
    end
    resources :posts
    get "my_posts", to: "posts#my_posts"
    resources :project_types
    resources :projects do
      member do
        get :delete_photo
        put :track
        put :un_track
      end
    end
    resources :properties
    resources :property_types
    resources :questions do
      member do
        put :proficiency_level_up
        put :proficiency_level_down
      end
    end
    resources :tasks do
      member do
        put :not_started
        put :start
        put :complete
        put :reactivate
        put :archive
      end
    end
    resources :timers do
      member do
        put :stop
      end
    end
    resources :todo_items do
      member do
        put :complete
        put :reactivate
      end
    end
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
    resources :articles, only: %i[index show]
  end
end
