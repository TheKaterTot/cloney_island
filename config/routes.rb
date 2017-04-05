Rails.application.routes.draw do
  root to: 'home#show', as: 'root'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/password/edit', to: "passwords#edit", as: :edit_password
  post '/password/edit', to: "passwords#update"

  resources :questions do
    resources :best_answers, only: [:create]
  end

  resources :upvotes, only: [:create, :destroy]
  resources :downvotes, only: [:create, :destroy]

  resources :users
  resources :answers, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :user_permissions, only: [:update]

  get 'authenticate_user', to: 'authentication#update'
  namespace :api do
    namespace :v1 do
      namespace :users do
        get "/by_reputation", to: "users_by_reputation#index"
        get "/banned", to: "users_banned#index"
      end

      resources :users, only: [:show, :index] do
      end

    end
  end

end
