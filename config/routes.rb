Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#home'
  resources :recipes

  # TODO: What params do I pass in if we don't have an id? The name of the recipe?

end
