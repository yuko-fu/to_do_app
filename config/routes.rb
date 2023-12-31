Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
