Rails.application.routes.draw do
  root 'recipe#index'

  get ':recipe/show', to: 'recipes#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
