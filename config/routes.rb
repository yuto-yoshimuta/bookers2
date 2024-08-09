Rails.application.routes.draw do
  resources :books
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: 'about'
end
