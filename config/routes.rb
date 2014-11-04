Rails.application.routes.draw do
  resources :users, except: :index
  resources :sessions, only: [:new, :create, :destroy]

  resources :games do
    resources :game_answers, only: :index, as: "answers"
  end
  resources :game_answers, only: [:create, :destroy], as: "answers"

  resources :rounds, only: [:create, :show] do
    member do
      post "guess" => "rounds#guess"
    end
  end


  namespace :api, defaults: { format: :json } do
    resources :users, only: :show

    resources :games do
      resources :game_answers, only: :index, as: "answers"
    end
    resources :game_answers, only: [:create, :update, :destroy], as: "answers"

    resources :rounds, only: [:create, :show, :update] do
      resources :round_answer_matches, only: :index, as: "answer_matches"
    end

    resources :round_answer_matches, only: :create, as: "answer_matches"
  end

  root to: "static_pages#root"
end
