Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:edit, :show, :index, :update]
  root to: 'homes#top'
  get 'home/about', to: 'homes#about', as: 'about'
end
