Rails.application.routes.draw do
  root 'recipes#search'

  # get 'recipes/search', to: 'recipes#search', as: 'recipe_search'
  get 'recipes/show', to: 'recipes#show', as: 'recipe'

  get 'recipes/index', to: 'recipes#index', as: 'recipes'

  # get 'recipes/search?:query', to: 'recipes#index'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
end
