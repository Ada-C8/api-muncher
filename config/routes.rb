Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'
  get 'recipes/search/', to: 'recipes#search', as: 'recipes_search'
  get 'page/:from/:to', to: 'recipes#search_by_page', as: 'lemon_tart'
  # post 'recipes/:keywords', to: 'recipes#index', as: 'recipes'
  get 'recipes/:id', to: 'recipes#show', as: 'recipe_show'

end
