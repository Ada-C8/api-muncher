Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'recipes#index'

  get '/recipes/search', to:'recipes#search', as: 'recipes_search'
  get '/recipes/:uri', to: 'recipes#show', as: 'recipe'
end
