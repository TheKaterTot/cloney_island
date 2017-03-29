Rails.application.routes.draw do

resources :questions, only: [:index]

root to: 'home#show', as: 'root'

end
