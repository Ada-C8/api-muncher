Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/recipes/', to: 'recipes#index', as: 'recipes' #recipes_path

  get '/recipes/search', to: 'recipes#search', as: 'recipe_search'

  get '/recipes/:id', to: 'recipes#show', as: 'recipe' #recipe_path
end
