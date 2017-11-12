Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#root'
  resources :recipes, controller: 'recipes', only: [:index, :show]
  # get '/recipes', to: 'recipes#index', as: 'recipes'
  # get 'recipes/:label', to: 'recipes#show', as: 'recipe'
end
