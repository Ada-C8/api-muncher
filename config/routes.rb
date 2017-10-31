Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#home'
  get '/recipes', to: 'recipes#index', as: "recipes"
  get '/recipes/:recipe/show', to: 'recipe#show', as: 'recipe'
  # get ':channel/new', to: 'chat#new', as: 'chat_new'
  # post ':channel', to: 'chat#create', as: 'chat_create'

end
