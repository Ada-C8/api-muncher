Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#main'
  resources :recipes

  get '/search', to: 'recipes#search', as: 'search'
end
