Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'recipies#root'
resources :recipies, only: [:index, :show]
# get ':recipie/:uri', to: 'recipies#show', as: recipe_path
# get 'recipies/:uri', to: 'recipies#show', as: recipe_path
# get '/:uri', to: 'recipies#show', as: recipe_path

end
