Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#main'

  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'

  get '/search', to: 'recipes#search', as: 'search'
end
