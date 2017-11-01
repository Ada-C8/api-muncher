Rails.application.routes.draw do

  root 'recipes#root'

  get '/logout', to: "users#logout"

  get "/auth/:provider/callback", to: "users#create"

  get '/recipes/', to: 'recipes#index', as: 'recipes'

  get 'recipes/:uri', to: 'recipes#show', as: 'recipe'

end
