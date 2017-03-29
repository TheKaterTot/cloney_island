Rails.application.routes.draw do

  root to: 'home#show', as: 'root'

  resources :questions, only: [:index, :show]


end
