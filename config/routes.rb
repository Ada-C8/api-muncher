Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'

  get 'recipes', to: 'recipes#index'
  get 'recipes/:recipe_label', to: 'recipes#show'

end
