Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :update]
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :labeling, only: [:create, :destroy]
  resources :labels, only: [:index, :new, :create, :edit, :update, :destroy]

  root to: "tasks#index"
end
