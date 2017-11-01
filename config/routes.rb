Rails.application.routes.draw do
  get ':recipe', to: 'recipe#show', as: 'show_recipe'
  root 'recipe#search_form'
  get 'recipes/search', to: 'recipe#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
