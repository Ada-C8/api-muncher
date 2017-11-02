Rails.application.routes.draw do
  root to: 'recipes#welcome'
  resources :recipes, only: [:index, :show]

end
