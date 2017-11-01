Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'searches#root'
  get 'index', to: 'searches#index', as: 'searches'
  get 'root', to: 'searches#index'
  get '/index/:label', to: 'searches#show', as: 'search'
end
