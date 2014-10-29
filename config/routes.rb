Rails.application.routes.draw do
  resources :users, except: :index

  resources :sessions, only: [:new, :create, :destroy]

  resources :games do
    resources :game_answers, only: :index, as: "answers"
  end
  resources :game_answers, only: [:create, :destroy], as: "answers"

  root to: 'games#index'
end
