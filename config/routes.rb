Rails.application.routes.draw do
  get 'users/create'

  get 'users/logout'

  root 'recipes#root'

  get '/recipes/', to: 'recipes#index', as: 'recipes'

  get 'recipes/:uri', to: 'recipes#show', as: 'recipe'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
