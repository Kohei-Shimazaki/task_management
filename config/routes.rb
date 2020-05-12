Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  root to: "tasks#index"
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
