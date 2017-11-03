Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'recipe#index'
  # get 'recipes', to: 'home#'

  root 'recipes#index'

  get ':/recipes/new', to: 'recipes#new', as: 'new_recipe'

  post '/recipes', to: 'recipes#create', as: 'recipes_create'

  # resources :recipes
end
