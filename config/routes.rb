Rails.application.routes.draw do

  root to: 'home#show', as: 'root'

  resources :users, only: [:new, :create, :show]
  resources :questions, only: [:index, :show]
end
