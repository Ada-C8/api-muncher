Rails.application.routes.draw do
  get 'recipes/:recipe', to: 'recipe#show', as: 'show_recipe'
  root 'recipe#search_form'
  get 'recipes/', to: 'recipe#list_search', as: 'recipes'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
