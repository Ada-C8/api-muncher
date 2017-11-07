Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'recipe#index'
  # get 'recipes', to: 'home#'

  root "home#index"

  # get "/recipes/", to: "recipes#index", as: "recipes"
  # resources :home

  resources :recipes, only: [:index]

  get "/recipe", to: "recipes#show", as: "recipe"
  # get '/recipes/:uri', to: "recipes#show", as: 'recipe'

  # resources :recipes
end
