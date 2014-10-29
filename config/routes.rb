Rails.application.routes.draw do
  resources :users, except: :index

  resources :sessions, only: [:new, :create, :destroy]

  resources :games do
    member do
      resources :game_answers, only: [:index, :new]
    end
  end
  resources :game_answers, only: [:create, :destroy]

  root to: 'games#index'
end
