Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'main#index'
  get '/attributions', to: 'main#attribution', as: 'attributions'

  # resources :recipes, only: [:index, :show]
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/recipes/*id', to: 'recipes#index', as: 'recipe_results'
  post '/recipes', to: 'recipes#search', as: 'search'
  get '/recipes/show/*id', to: 'recipes#show', as: 'recipe'

end
