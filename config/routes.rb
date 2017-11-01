Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'recipies#root'
resources :recipies, only: [:index, :show]
# get 'recipies/:uri', to: 'recipies#show', as: recipy_path
end
