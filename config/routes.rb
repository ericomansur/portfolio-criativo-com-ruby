# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "profiles#home"

  get "/search", to: "search#index", as: :search
  get "/explorar", to: "feed#index", as: :public_feed
  get "/ranking", to: "ranking#index", as: :ranking
  
  get "/seguindo", to: "feed#personalized", as: :personalized_feed

  resources :projects, only: [:index, :new, :create, :edit, :update, :destroy] do
    resource :like, only: %i[create destroy]
    resources :comments, only: :create
  end

  resources :notifications, only: [:index] do
    collection do
      patch :mark_all_as_read
    end
  end

  get "/@:username/seguidores", to: "follows#followers", as: :user_followers
  get "/@:username/seguindo", to: "follows#following", as: :user_following
  post "/@:username/follow", to: "follows#create", as: :follow_user
  delete "/@:username/unfollow", to: "follows#destroy", as: :unfollow_user

  get "/@:username", to: "profiles#show", as: :public_profile
  get "/@:username/:project_slug", to: "projects#public_show", as: :public_project
end