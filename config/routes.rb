Rails.application.routes.draw do
  resources :tickets
  get "user/profile"
  # API routes
  scope '/api', defaults: { format: :json } do
    scope '/v1' do
      devise_for :users, 
        path_names: { sign_in: 'login', sign_out: 'logout' },
        controllers: { registrations: 'registrations', sessions: 'sessions' },
        as: :api_v1

      devise_scope :user do
        get 'users/current', to: 'sessions#show'
      end

      resources :pages, only: %i[index]
    end
  end

  # Web routes using TurboDeviseController
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  
  get '/u/:id', to: 'users#profile', as: 'user'

  resources :posts
  resources :credit_cards, except: [:show, :new]

  get "about", to: "pages#about"
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
