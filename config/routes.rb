Rails.application.routes.draw do

  root 'recipes#home'
  get 'recipes/index', to: 'recipes#index'

  get 'recipes/show', to: 'recipes#show'

  get 'recipes/new', to: 'recipes#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
