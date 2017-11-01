Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root 'recipe#index' #not_implemented_yet

  root 'recipe#home'
  get '/recipes', to: 'recipe#index', as: 'recipe_results' #recipe_results path

  get ':recipe/', to: 'recipe#show', as: 'show_recipe'

end
