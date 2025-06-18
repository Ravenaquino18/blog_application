Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  # Custom profile route
  get '/u/:id', to: 'users#profile', as: 'user'

  # Static pages
  get 'about', to: 'pages#about'
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Posts and other resources
  resources :posts
  resources :credit_cards, except: [:show, :new]

  # API Routes (JSON)
  scope '/api', defaults: { format: :json } do
    scope '/v1' do
      devise_for :users,
        path: '',
        path_names: { sign_in: 'login', sign_out: 'logout' },
        controllers: {
          registrations: 'registrations',
          sessions: 'sessions'
        },
        as: :api_v1

      devise_scope :user do
        get 'users/current', to: 'sessions#show'
      end

      resources :pages, only: [:index]
    end
  end

  # Root path
  root 'pages#home'
end