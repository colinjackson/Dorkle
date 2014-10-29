Rails.application.routes.draw do
  resources :users, except: :index
  resources :sessions, only: [:new, :create, :destroy]
  resources :games

  root to: 'games#index'
end
