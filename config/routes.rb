Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#root'
  get 'search/:query', to: 'recipes#search', as: 'search'
  post 'recipe', to: 'recipes#create'
end
