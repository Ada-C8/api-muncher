Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recpie#index'
  get 'recpie/:q', to: 'recipe#result', as: "get_recpies"
  get 'recpie/:r', to: 'recipe#show', as: 'show_recpie'
end
