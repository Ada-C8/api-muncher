Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'search#new'

  post '/search/:ingredients/:page', to: 'search#create', as: 'search_results'

  get '/search/:title', to: 'search#show_recipe', as: 'show_recipe'


end
