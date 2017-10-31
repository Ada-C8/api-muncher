Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipe#root'

  get 'recipes', to: 'recipe#index'
  get 'recipies/:label', to: 'recipe#show'

  # get recipes/:uri or label is show


  # get 'search/:query', to: 'recipe#search', as: 'search'
  # post 'search/:query', to: 'recipe#search'

end
