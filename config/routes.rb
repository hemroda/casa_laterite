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

    resources :accounts do
      resources :managers, only: %i[new create destroy], module: :accounts
      member do
        put :validate_account
      end
      resources :tickets, module: :accounts
    end
    resources :addresses
    resources :articles
    resources :article_categories
    resources :campaigns
    resources :comments, only: [] do
      resources :comments, only: %i[new create destroy], module: :comments
    end
    resources :contributions do
      resources :payments, only: %i[new create destroy], module: :contributions
      member do
        put :validate
      end
    end
    resources :discussions do
      resources :comments, only: %i[new create destroy], module: :discussions
      member do
        put :generate_ticket_incident
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
    resources :questions
    resources :tasks do
      member do
        put :not_started
        put :start
        put :complete
        put :reactivate
        put :archive
      end
    end
    resources :tickets
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
    root "posts#index"

    resources :accounts
    resources :posts
    get "my_posts", to: "posts#my_posts"

    resources :accounts do
      resources :discussions, module: :accounts
    end
    resources :addresses
    resources :comments, only: [] do
      resources :comments, only: %i[new create destroy], module: :comments
    end
    resources :contributions, only: %i[index show] do
      resources :payments, only: %i[show], module: :contributions
    end
    resources :discussions do
      resources :comments, only: %i[new create destroy], module: :discussions
    end
    resources :payments, only: %i[edit show update]
    resources :properties, only: %i[index show] do
      resources :discussions, module: :properties
      member do
        get :investment_opportunity
      end
    end
    resources :projects
  end

  # WEBSITE
  namespace :website, path: "/" do
    get "/", to: "pages#homepage"
    resources :articles, only: %i[index show]
  end

  # ERROR PAGES
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all

  # ATTACHMENTS
  delete "attachments/:id/purge", to: "attachments#purge", as: :purge_attachment
end
