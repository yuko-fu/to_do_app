Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  # namespace :admin do
    resources :users, only: [:new, :create, :show]
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
