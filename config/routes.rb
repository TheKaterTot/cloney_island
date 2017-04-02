Rails.application.routes.draw do

  root to: 'home#show', as: 'root'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/password/edit', to: "passwords#edit", as: :edit_password
  post '/password/edit', to: "passwords#update"

  resources :questions
  resources :users
  resources :answers, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :user_permissions, only: [:update]
end
