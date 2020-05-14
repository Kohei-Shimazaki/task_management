Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  resources :tasks
  root to: "tasks#index"
  resources :users, only: [:new, :create, :show, :update]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
end
