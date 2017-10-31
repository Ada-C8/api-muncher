Rails.application.routes.draw do

root 'recipes#home'

get 'index', to: 'recipes#index', as: 'index_recipes'

get ':recipe/show', to: 'recipes#show', as: 'show_recipe'
end
