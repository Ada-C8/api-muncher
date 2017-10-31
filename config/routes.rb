Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipe#root'
  get 'search/:query', to: 'recipe#search', as: 'search'
  post ':recipe', to: 'recipe#create'

end
