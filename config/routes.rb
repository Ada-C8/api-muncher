Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "recipes#home"
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/:recipe', to: 'recipes#show', as: 'recipe_show'

end
