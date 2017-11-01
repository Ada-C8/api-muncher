Rails.application.routes.draw do

  root 'recipes#home'
  get 'recipes/index', to: 'recipes#index', as: 'recipes'

  get 'recipes/show/:id', to: 'recipes#show', as: 'recipes_show'

  get 'recipes/new', to: 'recipes#new', as: 'recipes_new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
