Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#root'
  # get 'search', to: 'recipes#search', as: 'search'
  # get 'recipes/:recipe', to: 'recipes#show', as: 'recipe'
  resources :recipes, only: [:index, :show]
end
