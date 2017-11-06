Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index', to: 'recipes#index', as: 'root'

  get 'recipes/search', to: 'recipes#search', as: 'search'

  resources :recipes, only: [:show, :index]

end
