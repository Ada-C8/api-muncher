Rails.application.routes.draw do
  get 'recipes/', to: 'recipe#list_search', as: 'recipes'
  get 'recipes/:recipe', to: 'recipe#show', as: 'show_recipe'
  root 'recipe#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
