Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'main#index'

  post '/recipes', to: 'recipes#index', as: 'search'
  
  get '/recipes', to: 'recipes#index', as: 'recipes'
end
