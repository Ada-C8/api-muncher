Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'
  get 'recipes/results', to: 'recipes#results', as: "get_recipes"
  get 'recipes/show/:uri', to: 'recipes#show', as: 'show_recipe'
end
