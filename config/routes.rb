Rails.application.routes.draw do

  resources :homepage, only: [:index]
  resources :recipes, only: [:index, :show]

  # get 'homepage/index'
  # get 'recipes/index'
  # get 'recipes/new'
  # get 'recipes/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
