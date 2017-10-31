Rails.application.routes.draw do
  root 'recipes#index'
  get 'recipes', to: 'recipes#show', as: 'recipe'
end
