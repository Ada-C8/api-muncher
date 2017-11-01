Rails.application.routes.draw do
  root 'recipes#search'

  get 'recipes/search', to: 'recipes#search', as: 'recipe_search'

  get 'recipes/index'

  get 'recipes/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
end
