Rails.application.routes.draw do
  get "dashboard/index" # You might consider removing this if 'root 'pages#home'' serves as your main dashboard.
  ##Uncomment if there is an issue
    #get 'transactions/index'
    #get 'transactions/new'
    #get 'transactions/create'
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

  # config/routes.rb (This line seems to be misplaced or redundant if you have posts resources already)
  get "posts/loan_calculation", to: "posts#loan_calculation" # Consider if this is needed or if it should be within resources :posts do ... end

  # config/routes.rb (This line seems to be misplaced or redundant if you have posts resources already)
  get "posts/loan_calculation", to: "posts#loan_calculation" # Consider if this is needed or if it should be within resources :posts do ... end

  # Transactions custom routes
  # Optional shortcut route
  get 'transelect', to: redirect('/transactions/transelect')

# Transactions custom routes
  get 'transactions/transelect', to: 'transactions#transelect', as: 'transelect_post'
  get 'transactions/start', to: 'transactions#start_transaction', as: 'start_transaction'


  resources :posts do
    member do
      patch :approve
      patch :reject
      post :validate
    end
  end

  resources :transactions, only: [:index, :new, :create]

  resources :credit_cards, except: [:show, :new, :loanselect]
  get 'loanselect', to: 'posts#loanselect', as: 'loanselect_post' # This `loanselect` action belongs in PostsController
  resources :transactions, only: [:index, :new, :create]

  # CORRECTED: Calculator routes now point to CalculatorController
  get 'interest_calculator', to: 'calculator#interest', as: :interest_calculator
  post 'calculate_interest', to: 'calculator#calculate_interest', as: :calculate_interest

  # CORRECTED: Penalty Calculator routes now point to CalculatorController
  get 'penalty_calculator', to: 'calculator#penalty', as: :penalty_calculator
  post 'calculate_penalty', to: 'calculator#calculate_penalty', as: :calculate_penalty

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

# NOTE: This `def loanselect` should NOT be in routes.rb.
# It should be a method inside your PostsController.
# def loanselect
#   # logic for loan selection page
# end