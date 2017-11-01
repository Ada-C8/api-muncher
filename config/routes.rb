Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#root'

  resources :recipes, only: [:index, :show]

  get '/no_match', to:'recipes#no_match', as: 'no_match'
end
