Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'munchers#root'
resources :muncher, only: [:index, :show]
end
