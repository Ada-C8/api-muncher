Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#search_form'
  get '/recipes/', to: 'recipes#search'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
end
