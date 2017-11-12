Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :recipes, only: [:index, :show]
  # root 'recipes#root'
  # get '/recipes', to: 'recipes#index', as: 'recipes'
  # get '/recipes/:label', to: 'recipes#show', as: 'recipe'

  root 'recipes#root'

  get '/recipes', to:'recipes#index', as: 'recipes'
  get '/recipe', to:'recipes#show', as: 'recipe'
end
