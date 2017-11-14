Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'recipes#index'

get 'results', to: 'recipes#results', as: :results
get 'show/:id', to: 'recipes#show', as: :show
end
