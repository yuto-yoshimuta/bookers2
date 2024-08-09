Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users, only: [:edit, :show, :index, :update]
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: 'about'
end
