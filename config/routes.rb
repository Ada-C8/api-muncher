Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "recipes#new"
  get 'search', to: 'recipes#search', as: 'search_recipe'
  get 'recipes', to:'recipes#index', as: 'recipes'
  get 'recipe/:name', to: 'recipes#show', as: 'recipe'

end
