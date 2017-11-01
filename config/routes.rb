Rails.application.routes.draw do

  root 'recipes#index'
  # resources :recipes, only: [:show]
  get "/recipes", to: "recipes#show"
end
