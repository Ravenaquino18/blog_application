Rails.application.routes.draw do
  get "dashboard/index" # You might consider removing this if 'root 'pages#home'' serves as your main dashboard.

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  get 'dashboard/statistics', to: 'dashboard#statistics'

  # Custom profile route
  get '/u/:id', to: 'users#profile', as: 'user'

  # Static pages
  get 'about', to: 'pages#about'

  # Health check
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Posts and other resources
  resources :posts
  resources :credit_cards, except: [:show, :new]

  # Calculator routes
  get 'interest_calculator', to: 'pages#interest_calculator', as: :interest_calculator
  post 'calculate_interest', to: 'pages#calculate_interest', as: :calculate_interest

  # Penalty Calculator routes
  get 'penalty_calculator', to: 'pages#penalty_calculator', as: :penalty_calculator
  post 'calculate_penalty', to: 'pages#calculate_penalty', as: :calculate_penalty

  # Overdues route
  get 'overdues', to: 'pages#overdues', as: :overdues

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