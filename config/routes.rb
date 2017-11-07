Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'
  # resources :recipes, only: [:index, :show]
  get 'recipes/:uri', to: 'recipes#show', as: 'recipe'
  get 'recipes', to: 'recipes#index'
end
