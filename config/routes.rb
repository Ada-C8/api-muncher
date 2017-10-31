Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'recipes#index'

  # resources :recipes

  get '/search', to:'recipes#search', as: 'recipes_search'

  # get ':recipes/new-search', to: 'recipes#new', as: 'recipes_new_search'

  # get ':channel/new', to: 'chat#new', as: 'chat_new'
  # post ':channel', to: 'chat#create', as: 'chat_create'
end
