Rails.application.routes.draw do
  root 'recipes#root'

  post ':search', to: 'recipes#index', as: 'index'

  get 'recipes/show'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
