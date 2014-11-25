Rails.application.routes.draw do
  resources :users, except: :index do
    collection do
      get "demo" => "users#demo"
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :notifications, only: [:update, :destroy]
  resource :search, only: [:query] do
    collection do
      match ":query" => "searches#query", via: :get, as: "query"
    end
  end

  resources :games do
    resources :game_answers, only: :index, as: "answers"
  end
  resources :game_answers, only: [:create, :destroy], as: "answers"

  resources :rounds, only: [:create, :show] do
    member do
      post "guess" => "rounds#guess"
      patch "finish" => "rounds#finish"
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :users, only: :show do
      resources :notifications, only: :index
    end
    resources :notifications, only: [:update, :destroy]

    resources :games do
      resources :game_answers, only: :index, as: "answers"
    end
    resources :game_answers, only: [:create, :update, :destroy], as: "answers"

    resources :rounds, only: [:create, :show, :update] do
      resources :round_answer_matches, only: :index, as: "answer_matches"
    end

    resources :round_answer_matches, only: :create, as: "answer_matches"

    root to: "static_pages#root"
  end

  post "/pusher/auth", to: "pusher#auth"
  root to: "static_pages#root"
end
