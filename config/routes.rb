Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  resources :tasks
  resources :users, only: [:create]
end
