Rails.application.routes.draw do

  root to: 'home#show', as: 'root'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :users, only: [:new, :create, :show]
  resources :questions, only: [:index, :show, :new, :create]


end
