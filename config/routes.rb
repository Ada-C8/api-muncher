Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'main#index', as: 'root'

  resources :recipes, only: [:index, :show]
  # get '/recipe/*id', to: 'recipes#show', as: 'recipe'
end
