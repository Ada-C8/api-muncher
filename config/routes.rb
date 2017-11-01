Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'recipes/', to: 'recipes#search', as: 'recipes_search'
  post 'recipes/:keywords', to: 'recipes#index', as: 'recipes_index'
  post 'recipe/:uri', to: 'recipe#show', as: 'recipe_show'

end
