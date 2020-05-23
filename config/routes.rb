Rails.application.routes.draw do
  root to: "tasks#index"

  resources :users, only: [:new, :create, :show, :update]
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      get 'close_to_deadline'
    end
  end
  resources :labeling, only: [:create, :destroy]
  resources :labels, only: [:index, :new, :create, :edit, :update, :destroy]
end
