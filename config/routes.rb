Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "profiles#home"

  get "/@:username", to: "profiles#show", as: :public_profile

  get "/@:username/:project_slug", to: "projects#public_show", as: :public_project

  get "/search", to: "search#index", as: :search


  resources :projects
end
