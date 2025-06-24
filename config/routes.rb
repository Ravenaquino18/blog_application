Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/new'
  get 'transactions/create'
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
  resources :posts do
    member do
      patch :approve
      patch :reject
      post :validate
    end
  end
  resources :credit_cards, except: [:show, :new, :loanselect]
  get 'loanselect', to: 'posts#loanselect', as: 'loanselect_post'
  resources :transactions, only: [:index, :new, :create]

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

def loanselect
  # logic for loan selection page
end